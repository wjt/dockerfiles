ARG BRANCH=latest
FROM registry.endlessm-sf.com/eos-toolbox:${BRANCH}

# Karton is actually better at this
RUN apt-get -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y build-dep \
        eos-installer \
        eos-payg \
        eos-payg-nonfree \
        flatpak \
        gnome-control-center \
        gnome-initial-setup \
        gnome-settings-daemon \
        gnome-shell \
        gnome-software \
        ostree \
    && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
        awscli \
        eos-shell-content-dev \
        flatpak \
        gir1.2-flatpak-1.0 \
        gir1.2-ostree-1.0 \
        libxml2-utils \
        ostree \
        python-pip \
        python3-boto \
        python3-git \
        python3-lxml \
        python3-pip \
        python3-polib \
    && \
    apt-get -y clean

# For  OBS
RUN pip install progressbar

# For gitlab-changelog.py
RUN pip3 install python-gitlab
