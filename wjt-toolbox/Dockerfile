ARG BRANCH=latest
FROM registry.endlessm-sf.com/eos-toolbox:${BRANCH}

# Karton is actually better at this
RUN apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y build-dep \
        eos-installer \
        gnome-control-center \
        gnome-initial-setup \
        gnome-settings-daemon \
        gnome-shell \
        gnome-software \
        gvfs \
        minilzip \
        ostree

RUN    DEBIAN_FRONTEND=noninteractive apt-get -y install \
        awscli \
        eos-shell-content-dev \
        flatpak \
        fonts-cantarell \
        fonts-lato \
        gir1.2-flatpak-1.0 \
        gir1.2-ostree-1.0 \
        gnome-control-center-data \
        libgit2-dev \
        libxml2-utils \
        ostree \
        python3-boto \
        python3-git \
        python3-lxml \
        python3-matplotlib \
        python3-pip \
        python3-polib
RUN apt-get -y clean

# For  OBS
RUN pip install progressbar

# For gitlab-changelog.py
RUN pip3 install python-gitlab 

# Buildstream: https://wiki.gnome.org/Newcomers/BuildSystemComponent
RUN pip3 install BuildStream \
    && \
    git clone --depth 1 https://gitlab.com/BuildStream/bst-external.git /opt/bst-external && \
    pip3 install -e /opt/bst-external
