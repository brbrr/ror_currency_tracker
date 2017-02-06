class CurrenciesController < ApplicationController
  # GET /currencies
  # GET /currencies.xml
  def index
    @currencies = Currency.all

    render json: @currencies
  end

  # GET /currencies/1
  def show
    @currency = Currency.find(params[:id])

    render json: @currency
  end
end
