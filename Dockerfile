FROM ubuntu:jammy

WORKDIR /root

ARG TLIVE_SCHEME
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get -qq update && apt-get install -qq -y --no-install-recommends \
    ca-certificates \
    perl-modules-5.34 \
    python3-pygments \
    libyaml-tiny-perl \
    libfile-homedir-perl \
    wget \
    fontconfig \
    fonts-inconsolata \
    fonts-ipaexfont-mincho \
    fonts-ipaexfont-gothic \
    gpg \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir texinstall \
    && wget -qO- https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz | tar xvz --strip-components=1 -C texinstall \
    && cd texinstall \
    && ./install-tl --no-interaction --scheme=$TLIVE_SCHEME --no-doc-install --no-src-install \
    && cd .. \
    && rm -rf texinstall
# Installation is done to an arch-specific location, under ...2022/bin, so link to it wherever it is (will only be one dir, so glob okay)
RUN ln -s /usr/local/texlive/2022/bin/* /usr/local/texlive/2022/bin/docker
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    TERM=dumb \
    PATH "$PATH:/usr/local/texlive/2022/bin/docker" \
    MANPATH "$MANPATH:/usr/local/texlive/2022/texmf-dist/doc/man" \
    INFOPATH "$INFOPATH:/usr/local/texlive/2022/texmf-dist/doc/info"
