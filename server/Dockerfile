FROM ruby

RUN gem install bundler
WORKDIR /code/server
COPY Gemfile ./
RUN bundler install
CMD ["/usr/local/bin/ruby", "server.rb"]
