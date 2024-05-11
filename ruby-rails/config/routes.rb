Rails.application.routes.draw do
  get '/', to: 'static#root'
  get '/details', to: 'static#details'
end
