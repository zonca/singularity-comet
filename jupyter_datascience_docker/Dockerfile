FROM jupyter/datascience-notebook:281505737f8a

USER root
RUN conda remove --quiet --yes jupyterhub

RUN conda install --quiet --yes \
    'jupyterhub=0.7.2' \
    'jupyterlab=0.27.*' \
    && conda clean -tipsy && \
    fix-permissions $CONDA_DIR

RUN jupyter serverextension enable --py jupyterlab --sys-prefix 

# comet mount points
RUN mkdir /oasis /projects /scratch
