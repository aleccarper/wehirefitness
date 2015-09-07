Rails.application.routes.draw do
  devise_for :admins
  root 'home#index'

  get '/jobs/new', to: 'jobs#new'

  post '/jobs/review', to: 'jobs#review'
  get '/jobs/review', to: 'jobs#review'

  post '/jobs/purchase', to: 'jobs#purchase'
  get '/jobs/purchase', to: 'jobs#purchase'

  post '/jobs/complete_purchase', to: 'jobs#complete_purchase'

  get '/jobs/thank_you', to: 'jobs#thank_you'

  get '/jobs/:id', to: 'jobs#show', as: 'job'

  post '/jobs/charge_and_publish', to: 'jobs#charge_and_publish'
  post '/jobs/unpublish', to: 'jobs#unpublish'
  post '/jobs/publish', to: 'jobs#publish'

  #misc
  get '/terms', to: 'legal#terms_and_conditions'
  get '/privacy', to: 'legal#privacy_policy'
end
