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
        genisoimage \
        gh \
        gir1.2-gnomedesktop-4.0 \
        git-absorb \
        git-evtag \
        git-revise \
        httpie \
        hyperfine \
        ipython3 \
        libglib2.0-dev \
        libsecret-1-dev \
        multitime \
        muon-meson \
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

COPY install-from-forge /usr/local/bin
RUN install-from-forge --format deb gitlab gitlab.com gitlab-org/cli && \
    install-from-forge --format tar github martinvonz/jj ./jj && \
    install-from-forge --format deb github gulbanana/gg

RUN dpkg-divert --divert /usr/bin/pkexec.orig --rename /usr/bin/pkexec
COPY pkexec /usr/bin

# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=878599
RUN make -C /usr/share/doc/git/contrib/credential/libsecret && \
    mv /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret /usr/local/bin && \
    make -C /usr/share/doc/git/contrib/credential/libsecret clean
