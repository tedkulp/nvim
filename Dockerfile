FROM rust:latest AS rust_builder

RUN git clone https://github.com/BurntSushi/ripgrep /tmp/ripgrep 
RUN cd /tmp/ripgrep && \
  cargo build --release && \
  cp ./target/release/rg /usr/local/bin/rg && \
  strip /usr/local/bin/rg

FROM ubuntu:22.04 AS builder

ARG BUILD_APT_DEPS="ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip git binutils cargo"
ARG DEBIAN_FRONTEND=noninteractive
ARG TARGET=stable

RUN apt update && apt upgrade -y && \
  apt install -y ${BUILD_APT_DEPS} && \
  git clone https://github.com/neovim/neovim.git /tmp/neovim
RUN cd /tmp/neovim && \
  git fetch --all --tags -f && \
  git checkout ${TARGET}
RUN cd /tmp/neovim && \
  make CMAKE_BUILD_TYPE=Release && \
  make CMAKE_INSTALL_PREFIX=/usr/local install
RUN strip /usr/local/bin/nvim

FROM ubuntu:22.04
COPY --from=builder /usr/local /usr/local/
COPY --from=rust_builder /usr/local/bin/rg /usr/local/bin/

ARG RUNTIME_APT_DEPS="build-essential git unzip nodejs npm"

RUN apt update && apt upgrade -y && \
  apt install -y ${RUNTIME_APT_DEPS} && \
  rm -rf /var/lib/apt/lists/*

RUN mkdir -p /data
WORKDIR /data
VOLUME [ "/data" ]

RUN mkdir -p /root/.config/nvim
COPY . /root/.config/nvim/

RUN nvim --headless "+Lazy! sync" +qa

ENV TERM=screen-256color

ENTRYPOINT [ "/usr/local/bin/nvim" ]
