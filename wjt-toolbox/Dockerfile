ARG BRANCH=latest
FROM localhost/eos-admin:${BRANCH}

COPY 50cacheopts /etc/apt/apt.conf.d

# TODO: ADD <url> <file>
ADD https://cli.github.com/packages/githubcli-archive-keyring.gpg /usr/share/keyrings/githubcli-archive-keyring.gpg
RUN \
    echo "deb [signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" > /etc/apt/sources.list.d/github-cli.list \
    && \
    DEBIAN_FRONTEND=noninteractive apt-get -y update \
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
        dconf-cli \
        flatpak \
        fonts-cantarell \
        fonts-lato \
        git-revise \
        gir1.2-flatpak-1.0 \
        gir1.2-ostree-1.0 \
        gnome-control-center-data \
        httpie \
        ipython3 \
        jenkins-job-builder \
        libgit2-dev \
        librsvg2-common \
        libxml2-utils \
        gh \
        multitime \
        ostree \
        postgresql-client \
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
        python3-polib \
        python3-progressbar \
        sqlite3 \
        whiptail \
        x11-utils \
    && \
    apt-get -y clean

# Buildstream: https://wiki.gnome.org/Newcomers/BuildSystemComponent
# Debian's is Too Old
RUN pip3 install BuildStream \
    && \
    git clone --depth 1 https://gitlab.com/BuildStream/bst-external.git /opt/bst-external && \
    pip3 install -e /opt/bst-external

# Forgive me for I have sinned
COPY install-deb-from-github-and-hope-for-the-best install-binary-from-github-and-hope-for-the-best /usr/local/bin
RUN install-deb-from-github-and-hope-for-the-best profclems/glab && \
    install-binary-from-github-and-hope-for-the-best transifex/cli
