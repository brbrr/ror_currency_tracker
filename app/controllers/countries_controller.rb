class CountriesController < ApplicationController
  # GET /countries
  def index
    @countries = Country.all

    render json: @countries
  end

  # GET /countries/1
  def show
    @country = Country.find(params[:id])
    render json: @country
  end

  # GET /countries/1/edit
  def edit
    @country = Country.find(params[:id])
  end

  # POST /countries
  def create
    @country = Country.new(params[:country].permit(:visited, :name, :code))

    if @country.save
      render json: @country, status: :created, location: @country
    else
      render json: @country.errors, status: :unprocessable_entity
    end
  end

  # PUT /countries/1
  def update
    @country = Country.find(params[:id])

    if @country.update_attributes(params[:country].permit(:visited, :name, :code))
      render json: @country
    else
      render json: @country.errors, status: :unprocessable_entity
    end
  end
end
