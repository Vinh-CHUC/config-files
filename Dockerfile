FROM ubuntu:18.04

RUN apt update && apt -y install git build-essential software-properties-common curl
RUN add-apt-repository -y ppa:deadsnakes/ppa

##############
### Python ###
##############
RUN apt install -y python3.8
RUN apt install -y python3.8-distutils
RUN apt install -y python3.8-dev
RUN ln -s /usr/bin/python3.8 /usr/bin/python
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python get-pip.py

############
### IDEs ###
############
RUN pip install streamlit
RUN pip install notebook
RUN pip install jupyter_contrib_nbextensions
RUN jupyter contrib nbextension install --sys-prefix
RUN pip install jupyter_nbextensions_configurator

### line_profiler
RUN pip install Cython
RUN git clone https://github.com/rkern/line_profiler.git
RUN find line_profiler -name '*.pyx' -exec cython {} \;
RUN cd line_profiler && pip install .

### IPython Config
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
COPY jupyter-custom.css ~/.jupyter/custom/custom.css

################
### Packages ###
################

# Base scientific packages
RUN pip install pandas numpy

# Plotting
RUN pip install bokeh holoviews

# ML
RUN pip install sklearn

# Statistics
RUN pip install pymc3
