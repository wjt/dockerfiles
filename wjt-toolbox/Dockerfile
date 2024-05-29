FROM docker.io/endlessm/eos-admin:latest

COPY 50cacheopts /etc/apt/apt.conf.d

# You might hope to use ADD <url> <file> to download the keyring into the right place.
# However, when ADD's first argument is a URL, it sets mode 0600 on the target file!
RUN \
    curl -fsSL -o /usr/share/keyrings/githubcli-archive-keyring.gpg https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" > /etc/apt/sources.list.d/github-cli.list \
    && \
    DEBIAN_FRONTEND=noninteractive apt-get -y update \
    && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install  \
        black \
        clangd \
        gcovr \
        gh \
        git-absorb \
        git-revise \
        httpie \
        ipython3 \
        libglib2.0-dev \
        libsecret-1-dev \
        multitime \
        pandoc \
        pigz \
        postgresql-client \
        python3-boto \
        python3-gi \
        python3-phabricator \
        python3-progressbar \
        python3-pylsp-black \
        python3-pylsp-isort \
        python3-pylsp-mypy \
        python3-pylsp-rope \
        sqlite3 \
        valgrind \
        whiptail \
    && \
    apt-get -y clean

# Forgive me for I have sinned
COPY install-deb-from-github-and-hope-for-the-best install-binary-from-github-and-hope-for-the-best /usr/local/bin
RUN install-deb-from-github-and-hope-for-the-best profclems/glab && \
    install-binary-from-github-and-hope-for-the-best martinvonz/jj ./jj

RUN dpkg-divert --divert /usr/bin/pkexec.orig --rename /usr/bin/pkexec
COPY pkexec /usr/bin

# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=878599
RUN make -C /usr/share/doc/git/contrib/credential/libsecret && \
    mv /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret /usr/local/bin && \
    make -C /usr/share/doc/git/contrib/credential/libsecret clean
