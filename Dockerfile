# How to build? (optional) (version is docker container related, not mbuild version)
# docker build . -f Dockerfile  -t cmelab/general

# How to run?
# docker run --rm -itp 8888:8888 cmelab/general:latest jupyter notebook --notebook-dir=/home/ --ip='*' --port=8888 --no-browser --allow-root

FROM cmelab/mbuild

RUN conda install -y -c glotzer -c conda-forge -c cmelab hoomd_dybond gsd freud signac signac-flow fresnel  && \
    conda clean -tipsy && \
    pip install  --no-cache-dir git+https://bitbucket.org/cmelab/cme_utils.git

RUN adduser -G root -S jovyan && \
    chown -R jovyan /opt/conda/ /home/jovyan
ENV NB_USER jovyan
USER $NB_USER
ENV XDG_CACHE_HOME /home/$NB_USER/.cache/
RUN MPLBACKEND=Agg $CONDA_DIR/bin/python -c "import matplotlib.pyplot"
WORKDIR /home/jovyan
ADD --chown=jovyan:jovyan notebooks/* /home/jovyan/
ADD --chown=jovyan:jovyan swc_files/ /home/jovyan/
ADD --chown=jovyan:jovyan dotfiles/* /home/jovyan/
CMD jupyter notebook --port=8888 --ip='*' --no-browser --notebook-dir=/home/jovyan --NotebookApp.iopub_data_rate_limit=100000000
