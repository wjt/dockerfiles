ARG BRANCH=latest
FROM registry.endlessm-sf.com/eos-toolbox:${BRANCH}

COPY 50cacheopts /etc/apt/apt.conf.d

# Karton is actually better at this
RUN DEBIAN_FRONTEND=noninteractive apt-get -y update
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

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
        awscli \
        dconf-cli \
        eos-shell-content-dev \
        flatpak \
        fonts-cantarell \
        fonts-lato \
        gir1.2-flatpak-1.0 \
        gir1.2-ostree-1.0 \
        gnome-control-center-data \
        httpie \
        ipython3 \
        jenkins-job-builder \
        libgit2-dev \
        libxml2-utils \
        ostree \
        postgresql-client \
        python3-boto \
        python3-git \
        python3-gitlab \
        python3-lxml \
        python3-matplotlib \
        python3-pip \
        python3-polib \
        python3-progressbar \
        shellcheck \
        x11-utils

RUN apt-get -y clean

# Buildstream: https://wiki.gnome.org/Newcomers/BuildSystemComponent
# Debian's is Too Old
RUN pip3 install BuildStream \
    && \
    git clone --depth 1 https://gitlab.com/BuildStream/bst-external.git /opt/bst-external && \
    pip3 install -e /opt/bst-external

# https://github.com/containers/toolbox/issues/145
COPY toolbox-host-runner /usr/local/bin
RUN chmod +x /usr/local/bin/toolbox-host-runner
RUN \
    ln -s /usr/local/bin/toolbox-host-runner /usr/local/bin/podman && \
    ln -s /usr/local/bin/toolbox-host-runner /usr/local/bin/docker && \
    true
