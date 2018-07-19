FROM jupyter/datascience-notebook:702d2f6a3eaa

USER root
RUN apt-get update && \
    apt-get -y --allow-unauthenticated install vim build-essential wget gfortran bison libibverbs-dev libibmad-dev libibumad-dev librdmacm-dev ibverbs-providers graphviz

RUN wget --quiet http://mvapich.cse.ohio-state.edu/download/mvapich/mv2/mvapich2-2.1.tar.gz && \
    tar xf mvapich2-2.1.tar.gz && \
    cd mvapich2-2.1 && \
    ./configure --prefix=/usr/local && \
    make -j4 && \
    make install && \
    /usr/local/bin/mpicc examples/hellow.c -o /usr/bin/hellow

# comet mount points
RUN mkdir /oasis /projects /scratch
