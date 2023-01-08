FROM ubuntu:latest

WORKDIR /root

ARG TEXLIVE_SCHEME
RUN apt-get update && apt-get install -y \
    perl-modules-5.34 \
    python3-pygments \
    libyaml-tiny-perl \
    libfile-homedir-perl \
    wget \
    fontconfig \
    fonts-inconsolata \
    fonts-ipaexfont-mincho \
    fonts-ipaexfont-gothic \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir texinstall \
    && wget -qO- https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz | tar xvz --strip-components=1 -C texinstall \
    && cd texinstall \
    && ./install-tl --no-interaction --scheme=$TEXLIVE_SCHEME --no-doc-install --no-src-install \
    && cd .. \
    && rm -rf texinstall
# Installation is done to an arch-specific location, under ...2022/bin, so link to it wherever it is (will only be one dir, so glob okay)
RUN ln -s /usr/local/texlive/2022/bin/* /usr/local/texlive/docker
ENV PATH "$PATH:/usr/local/texlive/docker"
