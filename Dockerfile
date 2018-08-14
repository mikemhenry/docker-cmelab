# How to build? (optional) (version is docker container related, not mbuild version)
# docker build . -f Dockerfile  -t cmelab/general

# How to run?
# docker run --rm -itp 8888:8888 cmelab/general:latest jupyter notebook --notebook-dir=/home/ --ip='*' --port=8888 --no-browser --allow-root

FROM cmelab/mbuild

RUN conda install -y -c conda-forge hoomd -c glotzer gsd frued signac signac-flow fresnel  && \
    conda clean -tipsy && \
    pip install pip install git+https://bitbucket.org/cmelab/cme_utils.git

CMD jupyter notebook --port=8888 --ip='*' --no-browser --notebook-dir=/home/ --allow-root --NotebookApp.iopub_data_rate_limit=100000000
