FROM ruby:3.2.2
RUN export RUBY_GC_STATS=1

RUN apt-get update && apt-get install -y \
  build-essential \
  libpng-dev libzip-dev \
  vim curl imagemagick

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Node.JS setup
RUN export NODE_VERSION=18.16.1\
  && cd /tmp\
  && wget https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz\
  && tar -C /usr/local --strip-components 1 -xzf node-v${NODE_VERSION}-linux-x64.tar.gz\
  && rm node-v${NODE_VERSION}-linux-x64.tar.gz

# update yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt update && apt install -y yarn

WORKDIR /webapp

ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN gem install bundler -v 2.4
RUN bundle install

# install yarn
RUN corepack enable
RUN corepack prepare yarn@stable --activate
RUN yarn init

# install packages
ADD package.json package.json
RUN yarn install

# cleanup any temporary apt files.
RUN rm -rf /var/lib/apt/lists/*\
  && apt-get purge --auto-remove\
  && apt-get clean

RUN rm Gemfile && rm Gemfile.lock
RUN rm package.json

RUN gem env
RUN node -v
RUN yarn -v
