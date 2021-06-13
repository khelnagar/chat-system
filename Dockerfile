# syntax=docker/dockerfile:1
FROM ruby:2.6.7
RUN apt-get update -qq && apt-get install -y nodejs

WORKDIR /myapp
COPY . /myapp
RUN bundle install

COPY docker-entry.sh /usr/bin/
RUN chmod +x /usr/bin/docker-entry.sh
ENTRYPOINT ["docker-entry.sh"]

EXPOSE 3000