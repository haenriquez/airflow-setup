# Airflow setup via docker

This project demonstrates how to build a docker image for Apache Airflow. It will be used to setup a local environment for development in a MacOS machine. 

## Environment setup

### Requirements

- Have `brew` installed.
- Have `Docker` installed. 

### Steps

1. Run `brew update`.
2. Run `brew install pyenv`.
3. Setup shell environment. If in MacOS run the commands below. If for some reason you need `pyenv` available in non interactive shells, run the same commands but redirect to your `.zprofile` file.
```
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
```
4. Reload your terminal or source your `.zshrc` file.
5. Run `pyenv install 3.8.12`. For the latest supported version by Airflow visit [Docker Image for Apache Airflow](https://airflow.apache.org/docs/docker-stack/index.html#docker-image-for-apache-airflow).
5. Set the local version of python running `pyenv local 3.8.12`.
6. Run `pip install pipenv`. Even though building Airflow images requires using a `requirements.txt` file, my personal preference to manage dependencies is using pipenv and a Pipfile. 
8. Create a virtual environment using `pipenv --python 3.8.12` followed by `pipenv shell`.
9. Create a `Pipfile` and add under the packages section your desired Airflow version.
```
[packages]
apache-airflow = "==2.6.1"
```
10. Install dependencies with `pipenv install`.
11. Create a `requirements.txt` file redirecting the output of `pipenv requirements > requirements.txt`.
12. Create a `Dockerfile` with the contents below.
```
FROM apache/airflow:slim-2.6.1-python3.8
USER airflow
COPY requirements.txt /
RUN pip install --no-cache-dir -r /requirements.txt
# optional if you already have a test DAG
COPY --chown=airflow:root test_dag.py /opt/airflow/dags
```
13. Build the image using docker CLI. 
14. All good! Time to test your image. 