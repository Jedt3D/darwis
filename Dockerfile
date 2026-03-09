FROM ruby:3.3.7-alpine

WORKDIR /app

RUN apk add --no-cache build-base sqlite-dev

COPY Gemfile Gemfile.lock ./
RUN bundle install --without development test

COPY . .

EXPOSE 9292

CMD ["bundle", "exec", "rackup", "-o", "0.0.0.0", "-p", "9292"]
