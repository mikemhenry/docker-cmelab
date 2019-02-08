# What is on this image?

[Docker image](https://hub.docker.com/r/cmelab/docker-cmelab/) with python 3.6, hoomd, foyer, mbuild, cme_utils, numpy, scipy, signac, signac-flow, freud, fresnel, and more!

# How can I use it locally?
`docker run --rm -itp 8888:8888 cmelab/docker-cmelab:latest jupyter notebook --notebook-dir=/home/jovyan --ip='*' --port=8888 --no-browser --allow-root`
