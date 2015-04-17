Rails.application.routes.draw do

  resources :randomizers
  root 'randomizers#new'
end
