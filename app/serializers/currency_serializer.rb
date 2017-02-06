class CurrencySerializer < ActiveModel::Serializer
  attributes :id, :name, :code, :country_id, :weight, :collector_value
end
