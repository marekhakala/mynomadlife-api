Rails.application.routes.draw do
  root to: "static_pages#home"
  
  # API
  namespace :api do
    namespace :v1 do

      # Cities
      resources :cities, param: "slug", only: [:index, :show] do
        collection do
          post :search
        end

        match "coworking" => "cities#coworking", via: :get
        match "image" => "cities#image", via: :get
      end

      # Fixer.io API with cache
      match "exchange_rates" => "cities#exchange_rates", via: :get
    end
  end
end
