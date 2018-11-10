# 8d9388cac562 from March 2018 is one of the latest Jupyter notebooks with Ubuntu 16.04
# 18.04 requires a kernel too recent to be run on Comet
FROM jupyter/datascience-notebook:8d9388cac562

USER root
RUN apt update && \
    apt -y --allow-unauthenticated install vim build-essential wget gfortran bison libibverbs-dev libibmad-dev libibumad-dev librdmacm-dev libmlx5-dev libmlx4-dev graphviz

RUN wget --quiet http://mvapich.cse.ohio-state.edu/download/mvapich/mv2/mvapich2-2.1.tar.gz && \
    tar xf mvapich2-2.1.tar.gz && \
    cd mvapich2-2.1 && \
    ./configure --prefix=/usr/local && \
    make -j4 && \
    make install && \
    /usr/local/bin/mpicc examples/hellow.c -o /usr/bin/hellow && \
    cd .. && rm -fr mvapich2-2.1

# comet mount points
RUN mkdir /oasis /projects /scratch

USER $NB_USER

RUN conda install --quiet --yes \
    'jupyterlab' \
    'dask' \
    'distributed' \
    'numba' && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
