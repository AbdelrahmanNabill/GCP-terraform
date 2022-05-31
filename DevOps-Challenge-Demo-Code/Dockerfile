FROM python:3.8

WORKDIR /root/

COPY . /root/

RUN pip install -r requirements.txt

ENV ENVIRONMENT=Dev
ENV HOST=localhost
ENV PORT=8000
ENV REDIS_HOST=localhost
ENV REDIS_PORT=6379
ENV REDIS_DB=0 

EXPOSE 8000

CMD ["python3","hello.py"]


