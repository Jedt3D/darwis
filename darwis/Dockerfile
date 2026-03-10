FROM ruby:3.4-alpine

WORKDIR /app

RUN apk add --no-cache build-base sqlite-dev sqlite libffi-dev git

COPY Gemfile ./
COPY z-ai-sdk-ruby /home/worajedt/RubymineProjects/z-ai-sdk-ruby
WORKDIR /home/worajedt/RubymineProjects/z-ai-sdk-ruby
RUN git init && git add -A && git config user.email "test@test.com" && git config user.name "Test"
WORKDIR /app
RUN gem install bundler -v 2.5.22 && bundle config set --local path 'vendor/bundle'
ENV PATH="/app/vendor/bundle/ruby/3.4.0/bin:${PATH}"
RUN bundle install

COPY . .

EXPOSE 9292

CMD ["bundle", "exec", "rackup", "-o", "0.0.0.0", "-p", "9292"]
