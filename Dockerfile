FROM ubuntu:14.04
RUN apt update && \
    apt-get install -y software-properties-common && \
    add-apt-repository --yes ppa:ubuntu-sdk-team/ppa && \
    apt update -qq && \
    apt-get install -y wget && \
    apt-get install -y build-essential && \
    apt-get install -y qtbase5-dev qtdeclarative5-dev libqt5webkit5-dev libsqlite3-dev && \
    apt-get install -y qt5-default qttools5-dev-tools
