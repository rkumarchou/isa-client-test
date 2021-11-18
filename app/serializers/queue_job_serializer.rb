class QueueJobSerializer < ActiveModel::Serializer
  attributes :id, :name, :status, :priority
end
