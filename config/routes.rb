Rails.application.routes.draw do
  get 'api/V1/company/:id', to: 'company#show'
  post 'api/V1/company', to: 'company#create'
end
