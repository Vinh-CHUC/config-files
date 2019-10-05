ARG BASE_CONTAINER=jupyter/base-notebook@sha256:a97a294194ab477be189b1208343786aa418fc0266caa5a1fc255a438ecbcb97
FROM $BASE_CONTAINER

USER root

RUN apt-get update
RUN apt-get -y install git

# Installing various packages, one docker RUN statement per package to maximise layer reuse/build time efficiency
RUN pip install tensorflow==1.14.0
RUN pip install tensorboard==1.14.0
RUN pip install tensorflow-estimator==1.14.0
RUN pip install tensorflow-hub==0.6.0
RUN pip install tensorflow-metadata==0.14.0
RUN pip install tensorflow-probability==0.7.0

RUN pip install spacy==2.1.8
RUN pip install nltk==3.3
RUN pip install pandas==0.25.1
RUN pip install scikit-learn==0.21.2
RUN pip install bokeh
RUN pip install holoviews
RUN pip install eli5

RUN pip install jupyter_contrib_nbextensions==0.5.1
RUN jupyter contrib nbextension install --sys-prefix
RUN pip install jupyter_nbextensions_configurator

RUN python -m spacy download en_core_web_md

RUN pip install seaborn==0.9.0
RUN pip install matplotlib==3.1.1
RUN pip install scipy==1.3.1
RUN pip install pymc3==3.7
RUN pip install pystan==2.19.0.0

USER jovyan

### IPYthon Config
RUN ipython profile create
COPY ipython_config.py /home/jovyan/.ipython/profile_default/ipython_config.py

### Some more jupyter config to install extensions
RUN mkdir -p $(jupyter --data-dir)/nbextensions && \
    cd $(jupyter --data-dir)/nbextensions && \
    git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding && \
    chmod -R go-w vim_binding
RUN jupyter nbextensions_configurator enable --user

RUN jupyter nbextension enable vim_binding/vim_binding
RUN jupyter nbextension enable toc2/main

RUN mkdir -p ~/.jupyter/custom
COPY jupyter-custom.css /home/jovyan/.jupyter/custom/custom.css
