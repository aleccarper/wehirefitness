namespace :whf do
  task :seed => :environment do
    Robo::Tretter::seed
  end
end
