Rails.application.routes.draw do
  root 'home#index'

  get '/jobs/new', to: 'jobs#new'

  post '/jobs/review', to: 'jobs#review'
  get '/jobs/review', to: 'jobs#review'

  post '/jobs/purchase', to: 'jobs#purchase'
  get '/jobs/purchase', to: 'jobs#purchase'

  post '/jobs/complete_purchase', to: 'jobs#complete_purchase'

  get '/jobs/:id', to: 'jobs#show', as: 'job'

end
