Rails.application.routes.draw do
  # API
  namespace :api do
    namespace :v1 do

      # Cities
      resources :cities, param: "slug", only: [:index, :show] do
        collection do
          post :search
        end

        match "coworking" => "cities#coworking", via: :get
      end

      # Fixer.io API with cache
      match "exchange_rates" => "cities#exchange_rates", via: :get
    end
  end
end
