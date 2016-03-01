web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb
worker: bundle exec sidekiq -i ${DYNO:-1} -C config/sidekiq.yml
