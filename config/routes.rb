CuiAboutme::Application.routes.draw do
  get 'users' => 'users#index'
  get ':id' => 'users#show'
  post 'signup' => 'users#create'
  put ':id' => 'users#update'
  root to: 'users#index'
end
