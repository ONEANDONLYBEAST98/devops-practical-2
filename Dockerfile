FROM debian:stretch-slim

RUN apt-get update && \
    apt-get install -y zip unzip curl && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

ARG USER_UID="1001"
ARG USER_NAME="developer"

RUN useradd -m -U -u $USER_UID $USER_NAME

USER $USER_UID

RUN curl -s "https://get.sdkman.io" | bash

ARG JAVA_VERSION="11.0.12-open"
ARG MAVEN_VERSION="3.8.4"

RUN bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && \
    yes | sdk install java $JAVA_VERSION && \
    yes | sdk install maven $MAVEN_VERSION && \
    sdk flush archives && \
    sdk flush temp"

ENV JAVA_HOME="/home/developer/.sdkman/candidates/java/current"
ENV MAVEN_HOME="/home/developer/.sdkman/candidates/maven/current"
ENV PATH="$JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH"
