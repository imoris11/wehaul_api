class RouteSerializer < ActiveModel::Serializer
  attributes :id, :from, :to, :token
end
