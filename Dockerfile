# pull the official docker image
FROM python:3.11.1-slim

# set work directory
WORKDIR /app

# set env variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# copy project files into the container
COPY . .

# wait for the database to be ready, then start uvicorn
CMD ["bash", "-c", "while !</dev/tcp/db/5432; do sleep 1; done; uvicorn app.main:app --host 0.0.0.0"]
