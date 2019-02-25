FROM amazonlinux:2
LABEL maintainer "e-koma <cjhhh529@gmail.com>"

USER root
WORKDIR /root

ENV NODE_VERSION=11.x \
    RUBY_VERSION=2.5.3 \
    PATH="/root/.rbenv/bin:$PATH"

RUN yum install -y \
    bzip2 \
    curl \
    cyrus-sasl-devel \
    gcc-c++ \
    gettext \
    git \
    glibc-headers \
    jq \
    libffi-devel \
    libxml2 \
    libxml2-devel \
    libxslt \
    libxslt-devel \
    libyaml-devel \
    make \
    openssl-devel \
    readline \
    readline-devel \
    sqlite-devel \
    tar \
    zlib \
    zlib-devel \
    # Install Node.js, npm, serverless
    && curl --silent --location https://rpm.nodesource.com/setup_${NODE_VERSION} | bash - \
    && yum install -y nodejs \
    && npm install -g serverless \
    # Install Ruby
    && git clone https://github.com/rbenv/rbenv.git ~/.rbenv \
    && git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build \
    && ~/.rbenv/plugins/ruby-build/install.sh \
    && rbenv install ${RUBY_VERSION} \
    && echo 'eval "$(rbenv init -)"' >> ~/.bash_profile \
    && . ~/.bash_profile \
    && rbenv rehash \
    && rbenv global ${RUBY_VERSION} \
    && gem install bundler \
    && rm -rf /var/cache/yum/* \
    && yum clean all

