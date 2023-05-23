FROM apache/airflow:slim-2.6.1-python3.8
USER airflow
COPY requirements.txt /
RUN pip install --no-cache-dir -r /requirements.txt
COPY --chown=airflow:root test_dag.py /opt/airflow/dags