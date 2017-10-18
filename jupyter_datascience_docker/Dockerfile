FROM jupyter/datascience-notebook:281505737f8a

ARG JUPYTERHUB_VERSION=0.7.2

RUN pip install --upgrade --no-deps jupyterhub==$JUPYTERHUB_VERSION jupyterlab

RUN jupyter serverextension enable --py jupyterlab --sys-prefix 

# comet mount points
USER root
RUN mkdir /oasis /projects /scratch
