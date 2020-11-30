FROM python:latest

COPY . .
COPY requirements.txt requirements.txt

ENV POSTGRES_USER="user"
ENV POSTGRES_PASSWORD="password"
ENV POSTGRES_DB="database"
ENV CSV_FILENAME="data.csv"


RUN pip install -r requirements.txt
RUN python -m manager

RUN wget https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh -P /
RUN chmod +x /wait-for-it.sh
ENTRYPOINT ["/wait-for-it.sh", "db:5432", "--"]

EXPOSE 5432

CMD ["python", "pip", "-m", "manager"]