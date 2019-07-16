FROM python:3
MAINTAINER Rodrigo Oliveira <allrod5@hotmail.com>

ENV PYENV_ROOT /root/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH


# Install base system libraries.
RUN apt-get update && \
    apt-get install -y $(cat ./base_dependencies.txt) && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /etc/dpkg/dpkg.cfg.d/02apt-speedup


# Install pyenv and default python version.
ENV PYTHONDONTWRITEBYTECODE true
RUN git clone https://github.com/yyuu/pyenv.git /root/.pyenv && \
    cd /root/.pyenv && \
    git checkout `git describe --abbrev=0 --tags`
RUN pyenv install && \
    pyenv global $(cat .python-version)


# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
