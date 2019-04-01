# How to build? (optional) (version is docker container related, not mbuild version)
# docker build . -f Dockerfile  -t cmelab/general

# How to run?
# docker run --rm -itp 8888:8888 cmelab/general:latest jupyter notebook --notebook-dir=/home/ --ip='*' --port=8888 --no-browser --allow-root
# How to run just like it'll appear on codelab (or elsewhere)
# docker run --rm -itp 8888:8888 cmelab/general:latest jupyter notebook --notebook-dir=/home/jovyan --ip='*' --port=8888 --no-browser --allow-root

FROM cmelab/mbuild

RUN apk update && \
    apk add nano less R R-dev && \
    conda install -y -c conda-forge hoomd gsd freud signac signac-flow fresnel  && \
    conda clean -tipsy && \
    pip install  --no-cache-dir git+https://bitbucket.org/cmelab/cme_utils.git

RUN adduser -G root -S jovyan && \
    chown -R jovyan /opt/conda/ /home/jovyan
ENV NB_USER jovyan
USER $NB_USER
ENV XDG_CACHE_HOME /home/$NB_USER/.cache/
RUN MPLBACKEND=Agg $CONDA_DIR/bin/python -c "import matplotlib.pyplot"
WORKDIR /home/jovyan
ADD --chown=jovyan:root notebooks/ /home/jovyan/
ADD --chown=jovyan:root swc_files/ /home/jovyan/
ADD --chown=jovyan:root dotfiles/ /home/jovyan/
CMD jupyter notebook --port=8888 --ip='*' --no-browser --notebook-dir=/home/jovyan --NotebookApp.iopub_data_rate_limit=100000000