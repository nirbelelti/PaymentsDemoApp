FROM ruby:3.3.0 AS Wiled-Payments
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Create default directory
RUN mkdir /wiledpayments
# Stet work default directory
WORKDIR /wiledpaymentsapi

# Coppy gem files into working directory
COPY  Gemfile /wiledpaymentsapi/Gemfile
COPY  Gemfile.lock /wiledpaymentsapi/Gemfile.lock
#Copy app files
COPY . /wiledpaymentsapi

# Install rails
RUN gem install rails bundler
RUN bundle install
RUN bundle exec rails db:create
RUN bundle exec rails db:migrate
RUN bundle exec rails db:seed

CMD ["bundle", "exec", "rails", "server","-p","3000", "-b", "0.0.0.0"]