CuiAboutme::Application.routes.draw do
  get    'users'  => 'users#index'
  get    ':id'    => 'users#show'
  post   'signup' => 'users#create'
  put    ':id'    => 'users#update'
  delete ':id'    => 'users#destroy'

  root to: 'users#index'
end
