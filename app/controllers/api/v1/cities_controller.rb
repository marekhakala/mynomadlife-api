require 'rest-client'

module Api::V1
  class CitiesController < ApiController
    include CitiesHelper

    before_action :set_city, only: [:show, :image, :coworking]
    before_action :set_cities, only: [:index, :create]
    before_action :set_exchange_rates, only: [:index, :exchange_rates]

    def index
      serializable_resource = ActiveModelSerializers::SerializableResource.new(@cities_paginate, { root: "entries" })
      render json: { total_entries: @cities.count, total_pages: @cities_paginate.total_pages,
        per_page: @cities_paginate.per_page, current_page: @cities_paginate.current_page,
        entries: serializable_resource.as_json }, root: 'cities'
    end

    def search
      if params.has_key?("slugs") and params["slugs"].kind_of?(Array)
        set_cities_search(parse_params_slugs(params["slugs"]))
      else
        @cities = []
      end

      serializable_resource = ActiveModelSerializers::SerializableResource.new(@cities, { root: "entries" })
      render json: { total_entries: @cities.count, entries: serializable_resource.as_json }, root: 'cities'
    end

    def show
      serializable_resource = ActiveModelSerializers::SerializableResource.new(@city)
      render json: serializable_resource.as_json
    end

    def image
      city_slug_image ="#{Rails.root}/public/uploads/city/image/#{@city.id}/#{@city.slug}.jpg"
      send_file city_slug_image, type: "image/jpeg", disposition: "inline"
    end

    def coworking
      serializable_resource = ActiveModelSerializers::SerializableResource.new(@city.city_coworking_places)
      render json: { total_entries: @city.city_coworking_places.count, entries: serializable_resource.as_json }, root: 'coworking'
    end

    def exchange_rates
      serializable_resource = ActiveModelSerializers::SerializableResource.new(@exchange_rates)
      render json: { exchange_rates: serializable_resource.as_json }, root: 'exchange_rates'
    end

    protected
      def set_city
        set_cities
        @citySlug = params[:city_slug].nil? ? params[:slug] : params[:city_slug]
        @city = @cities.find_by!(slug: @citySlug)
      end

      def set_cities_search conditions
        where_clause = ""
        where_vars = []
        @cities = City.includes(:city_score)

        conditions.each_with_index do |condition, index|
            where_clause += " or " if index != 0
            where_clause += "(#{condition[0]})"
            where_vars << condition[1]
        end

        @cities = @cities.where(where_clause, *where_vars).references(:city_score)
      end

      def set_cities_filters
        @cities = City.includes(:city_score)
        parse_params(params).each { |condition| @cities = @cities.where(condition[0], condition[1]) }
        @cities = @cities.references(:city_score)
      end

      def set_cities
        set_cities_filters
        @page = params[:page].nil? ? 1 : params[:page]

        begin
          @cities_paginate = @cities.paginate(page: @page, per_page: 50).order('rank ASC')
        rescue => e
          @cities_paginate = @cities.paginate(page: 1, per_page: 50).order('rank ASC')
        end
      end

      def set_exchange_rates
        @database_data = EcbExchangeRate.order("update_date DESC").all
        @exchange_rates_last = @database_data.first

        if @exchange_rates_last.update_date.nil? or @exchange_rates_last.created_at.strftime("%Y-%m-%d") != Time.now.strftime("%Y-%m-%d")
          setup_from_api_exchange_rates
        end
      end
  end
end
