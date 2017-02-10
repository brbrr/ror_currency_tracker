module Api::V1
  class CountriesController < ApiController
    # GET /api/v1/countries
    def index
      @countries = params[:visited] == 'true' ? Country.visited : Country.all
      render json: @countries
    end

    # GET /api/v1/countries/1
    def show
      @country = Country.find(params[:id])
      render json: @country
    end

    # GET /api/v1/countries/1/edit
    def edit
      @country = Country.find(params[:id])
    end

    # POST /api/v1/countries
    def create
      @country = Country.new(params[:country].permit(:visited, :name, :code))

      if @country.save
        render json: @country, status: :created
      else
        render json: @country.errors, status: :unprocessable_entity
      end
    end

    # PUT /api/v1/countries/1
    def update
      @country = Country.find(params[:id])

      if @country.update_attributes(params[:country].permit(:visited, :name, :code))
        render json: @country
      else
        render json: @country.errors, status: :unprocessable_entity
      end
    end

    # GET /api/v1/countries/visits-over-time
    def visits_over_time
      render json: Country.visited.map(&:updated_at)
    end

    # GET /api/v1/countries/vs
    def vs
      render json: [Country.visited.count, Country.not_visited.count]
    end
  end
end
