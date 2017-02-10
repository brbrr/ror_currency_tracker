module Api::V1
  class CurrenciesController < ApiController
    # GET /api/v1/currencies
    def index
      @currencies = params[:collected] == 'true' ? Currency.collected : Currency.all

      render json: @currencies
    end

    # GET /api/v1/currencies/1
    def show
      @currency = Currency.find(params[:id])

      render json: @currency
    end
  end
end
