ARG BRANCH=latest
FROM registry.endlessm-sf.com/eos-toolbox:${BRANCH}

COPY 50cacheopts /etc/apt/apt.conf.d

# Karton is actually better at this
RUN DEBIAN_FRONTEND=noninteractive apt-get -y update \
    && \
    DEBIAN_FRONTEND=noninteractive apt-get -y build-dep \
        eos-installer \
        eos-updater \
        gnome-control-center \
        gnome-initial-setup \
        gnome-settings-daemon \
        gnome-shell \
        gnome-software \
        ostree \
    && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
        awscli \
        dconf-cli \
        eos-shell-content-dev \
        flatpak \
        flake8 \
        fonts-cantarell \
        fonts-lato \
        git-revise \
        gir1.2-flatpak-1.0 \
        gir1.2-ostree-1.0 \
        gnome-control-center-data \
        httpie \
        ipython3 \
        jenkins-job-builder \
        jq \
        libgit2-dev \
        librsvg2-common \
        libsecret-tools \
        libxml2-utils \
        mmdebstrap \
        multitime \
        ostree \
        postgresql-client \
        python3-boto \
        python3-boto3 \
        python3-cairo \
        python3-gi-cairo \
        python3-git \
        python3-github \
        python3-gitlab \
        python3-ipdb \
        python3-lxml \
        python3-matplotlib \
        python3-netaddr \
        python3-pandas \
        python3-pip \
        python3-polib \
        python3-progressbar \
        python3-venv \
        shellcheck \
        sqlite3 \
        transifex-client \
        whiptail \
        x11-utils \
    && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
        --no-install-recommends \
        docker-compose \
    && \
    apt-get -y clean

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

# https://github.com/endlessm/eos-administration/tree/master/ansible#installation
# Some bits, like boto3, are installed with apt above
RUN pip3 install --system \
    ansible \
    hvac \
    packet-python \
    torf

# We are currently on Terraform 0.12, check https://github.com/endlessm/eos-administration/tree/master/terraform#readme
RUN wget --no-verbose https://releases.hashicorp.com/terraform/0.12.31/terraform_0.12.31_linux_amd64.zip && \
    mkdir -p /usr/local/bin && \
    unzip terraform_0.12.31_linux_amd64.zip terraform -d /usr/local/bin && \
    rm terraform_0.12.31_linux_amd64.zip

# Forgive me for I have sinned
COPY install-deb-from-github-and-hope-for-the-best /usr/local/bin
RUN install-deb-from-github-and-hope-for-the-best cli/cli
RUN install-deb-from-github-and-hope-for-the-best profclems/glab

RUN \
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" >/etc/apt/sources.list.d/google-cloud-sdk.list \
    && \
    curl -o /usr/share/keyrings/cloud.google.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg \
    && \
    DEBIAN_FRONTEND=noninteractive apt-get update -y \
    && \
    DEBIAN_FRONTEND=noninteractive apt-get install google-cloud-sdk -y
