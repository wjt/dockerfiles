ARG BRANCH=latest
FROM registry.endlessm-sf.com/eos-toolbox:${BRANCH}

# Karton is actually better at this
RUN apt-get -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y build-dep eos-installer gnome-initial-setup gnome-settings-daemon eos-payg eos-payg-nonfree && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install python-pip python3-pip python3-polib python3-boto libxml2-utils gir1.2-ostree-1.0 gir1.2-flatpak-1.0 awscli && \
    apt-get -y clean

# For  OBS
RUN pip install progressbar
