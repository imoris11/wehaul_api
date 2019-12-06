class ScheduleSerializer < ActiveModel::Serializer
  attributes :id, :title, :header_photo, :date_time
  has_one :user
end
