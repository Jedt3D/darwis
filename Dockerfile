FROM ruby:3.3.7-alpine

WORKDIR /app

RUN apk add --no-cache build-base sqlite-dev sqlite

COPY Gemfile ./
RUN bundle config force_ruby_platform true && \
    bundle config build.sqlite3 --with-system-libraries && \
    bundle install

COPY . .

EXPOSE 9292

CMD ["bundle", "exec", "rackup", "-o", "0.0.0.0", "-p", "9292"]
