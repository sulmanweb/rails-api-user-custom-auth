FROM ruby:2.7.3
RUN apt-get update -qq && apt-get install -y postgresql-client
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN mkdir -p /myapp/log && touch /myapp/log/development.log
RUN gem install bundler
RUN bundle install
COPY . /myapp
RUN gem install foreman