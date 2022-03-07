FROM ruby:3.0.1
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /webapp
COPY . /webapp/

ENV BUNDLE_PATH /gems
RUN gem install bundler -v 2.3.7
RUN bundle install

# Add a script to be executed every time the container starts.
ENTRYPOINT ["bin/rails"]

# Configure the main process to run when running the image
CMD ["s", "-b", "0.0.0.0"]

EXPOSE 3000
