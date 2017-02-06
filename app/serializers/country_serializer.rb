class CountrySerializer < ActiveModel::Serializer
  attributes :id, :name, :code, :visited
end
