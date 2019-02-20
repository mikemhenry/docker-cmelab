# How to build? (optional) (version is docker container related, not mbuild version)
# docker build . -f Dockerfile  -t cmelab/general

# How to run?
# docker run --rm -itp 8888:8888 cmelab/general:latest jupyter notebook --notebook-dir=/home/ --ip='*' --port=8888 --no-browser --allow-root
# How to run just like it'll appear on codelab (or elsewhere)
# docker run --rm -itp 8888:8888 cmelab/general:latest jupyter notebook --notebook-dir=/home/jovyan --ip='*' --port=8888 --no-browser --allow-root

FROM cmelab/mbuild

RUN apk update && \
    apk add nano man man-pages mdocml-apropos less less-doc R R-dev && \
    conda install -y -c conda-forge hoomd gsd freud signac signac-flow fresnel  && \
    conda clean -tipsy && \
    pip install  --no-cache-dir git+https://bitbucket.org/cmelab/cme_utils.git
ENV PAGER less
RUN MPLBACKEND=Agg $CONDA_DIR/bin/python -c "import matplotlib.pyplot"
