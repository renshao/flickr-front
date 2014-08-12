Rails.application.routes.draw do
  root 'search#index'

  get 'search' => 'search#search', :as => :search
end
