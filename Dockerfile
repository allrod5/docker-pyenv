FROM python:3.7.2
MAINTAINER Rodrigo Oliveira <allrod5@hotmail.com>

ADD . .

ENV PYENV_ROOT /root/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH


# Install base system libraries.
RUN apt-get update && \
    apt-get install -y $(cat ./base_dependencies.txt) && \
    apt-get clean


# Install pyenv and default python version.
ENV PYTHONDONTWRITEBYTECODE true
RUN curl https://pyenv.run | bash
   
RUN eval "$(pyenv init -)" && \
    eval "$(pyenv virtualenv-init -)"
   
RUN pyenv update
    
RUN pyenv install && \
    pyenv global $(cat .python-version)


# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
