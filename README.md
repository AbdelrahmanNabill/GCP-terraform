# GCP-terraform

## first:
- Create project from console : iti-project
![1](https://user-images.githubusercontent.com/95745245/167253127-0a76faf1-e4b9-49c9-ba72-933d4e774251.png)

## Steps Of Terraform Code:

- in main.tf i selected the provider,project and region.
- in vpc.tf i created my custom vpc vpc-gcp.
- in subnets i created 2 subnets.
  - the management-subnet where the private vm and nat will be placed in.
  - the retstricted-subnet where the gke cluster node will be in and secondary_ip_range for pods and services.
- in nat-gateway.tf i created the router and nat in us-central1 region and in management-subnet.
- in service account.tf i created a custom service account to use in the private vm and worker nodes.
- in vm.tf i created the private vm in management-subnet to access the cluster master-node.
- in firewall.tf i created a rule to allow ssh to open port 22 to ssh in the private vm with iap.
- in gke.tf i created gke cluster ( multi-zonal cluster ) in us-central1-a and us-central1-b.
- in nodepool.tf i created the node-pool with 2 in every region.


## Command to configure Docker & gcloud to work with GCR of your project:
* Enable GCR API .
* Make sure that your account has all permissions to GCR .
* Install docker on your local machine .
* Run command in your local machine
```sh
gcloud auth configure-docker
```

* Create image from DockerFile by command and upload from local to GCR .
```sh
docker build -t <image_name> .
```
> Note: .env file to be aware of application environmental variables gonna pass through deployment on cluster GKE .

* We need image redis to be uploaded from local to GCR .
* Command used to push image from local machine to GCR .
```sh
docker tag <image_name> gcr.io/<project_name>/<image_name>
```
```sh
docker push gcr.io/<project_name>/<image_name>
```
* Command used to pull image from GCR to VM.

```sh
docker pull gcr.io/<project_name>/<image_name>
```

## Steps Of Terraform resources creation:

```sh
terraform init 
```
```sh
terraform plan 
```
```sh
terraform apply 
```

## screenshots of resources.

![Screenshot from 2022-05-07 11-47-06](https://user-images.githubusercontent.com/95745245/167253979-790d62a3-5bb9-4c3d-aeaa-056562b4ddcb.png)

![Screenshot from 2022-05-07 11-47-18](https://user-images.githubusercontent.com/95745245/167253987-4d0cad75-e0bf-4a75-8003-d85d4d95facc.png)

![Screenshot from 2022-05-07 11-47-38](https://user-images.githubusercontent.com/95745245/167253991-fe282822-19ef-424d-a650-6ee6a59840f1.png)

![Screenshot from 2022-05-07 11-47-40](https://user-images.githubusercontent.com/95745245/167253994-debf5364-ef04-4e8f-b3bc-4af4151d64b5.png)

![Screenshot from 2022-05-07 11-47-56](https://user-images.githubusercontent.com/95745245/167254001-b52f2b6b-b731-40cc-a2f3-fdcbd34cc02a.png)


# Deploying Kubernates resources:

## Steps:
* SSH to private VM .
```sh
gcloud compute ssh --zone <zone_name> <vm-name>  --tunnel-through-iap --project <project_name>
```
* Download Docker on your VM
```sh
curl -fsSL https://test.docker.com -o test-docker.sh 
```
```sh
sudo sh test-docker.sh
```
```sh
sudo usermod -aG docker ${USER}
```
```sh
gcloud auth config-docker
```
- Then reboot the VM .

* From Your Private VM: SSH to the cluster
```sh
gcloud container clusters get-credentials <cluster_name>
```

* Create the files using the commands in the following order:
```sh
kubectl create -f redis-db.yaml
```
```sh
kubectl create -f backend-service.yaml
```
> Note: Assign backend-svc generated IP to env variables "REDIS_HOST" of python-app-deploy                                                                                          [{name of your service}.default.svc.cluster.local]

```sh
kubectl create -f python-app.yaml
```
```sh
kubectl create -f loadblancer.yaml
```

## screenshots of deployments


![Screenshot from 2022-05-07 11-45-22](https://user-images.githubusercontent.com/95745245/167254117-6b4d23b7-671b-4d7f-9ae6-c4f728c8c677.png)

![Screenshot from 2022-05-07 11-45-38](https://user-images.githubusercontent.com/95745245/167254121-0c0ca92b-2e34-4b43-b9fd-deeca3dcea4b.png)

![Screenshot from 2022-05-07 11-45-50](https://user-images.githubusercontent.com/95745245/167254125-2dd003ac-9705-417d-9a31-cfd1f572853c.png)

![Screenshot from 2022-05-07 11-46-18](https://user-images.githubusercontent.com/95745245/167254129-3cf75b88-4338-4b57-8622-c9dc9d625b16.png)

## access the app through loadbalancer ip address

![Screenshot from 2022-05-07 11-46-06](https://user-images.githubusercontent.com/95745245/167254190-d268a5e3-369f-48b0-baa4-a15cc4831479.png)
