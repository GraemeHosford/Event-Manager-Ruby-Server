Rails.application.routes.draw do
  resources :companys
  get 'invite_notification', to: 'notifications#send_invite_notification'
end
