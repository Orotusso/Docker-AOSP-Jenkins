FROM ubuntu:latest

LABEL version="1.0" author="orotusso@protonmail.com" description="A minimal automated environment for compiling AOSP with Jenkins" license="CC0 Public Domain"

ENV AOSP_BRANCH="android-14.0.0_r28"
ENV AOSP_URL="https://android.googlesource.com/platform/manifest"
ENV LUNCH_TARGET=""
ENV THREADS="4"

# MODIFY ^^
# DO NOT MODIFY \/\/

RUN apt update
RUN apt install git-core gnupg flex bison build-essential zip curl zlib1g-dev libc6-dev-i386 libncurses5 x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig python3 -y
RUN touch /tmp/repo
RUN curl -o /tmp/repo https://storage.googleapis.com/git-repo-downloads/repo
RUN gpg --recv-keys 8BB9AD793E8E6153AF0F9A4416530D5E920F5C65
RUN curl -s https://storage.googleapis.com/git-repo-downloads/repo.asc | gpg --verify - /tmp/repo && install -m 755 /tmp/repo /usr/bin/repo
RUN git config --global user.email "automation@yggdrasilsys.com"
RUN git config --global user.name "Automated Process - NO REPLY"
RUN mkdir /aosp /aosp_out

WORKDIR /aosp
ENV OUT_DIR="/aosp_out"
ADD wrapper /aosp/
RUN chmod 755 wrapper