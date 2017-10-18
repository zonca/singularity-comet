FROM jupyter/datascience-notebook:01c9e6c66b15391a71b8aa70f68f01fcf09c7ebd

ARG JUPYTERHUB_VERSION=0.7.2

RUN pip install --upgrade --no-deps jupyterhub=$JUPYTERHUB_VERSION jupyterlab

RUN jupyter serverextension enable --py jupyterlab --sys-prefix 

# comet mount points
RUN mkdir /oasis /projects /scratch
