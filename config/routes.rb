Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/departments', to: 'department#index'
  get '/employees/:id', to: 'employees#show'
  post '/employees/:id', to: 'employees#create'
end
