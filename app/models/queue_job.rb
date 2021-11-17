class QueueJob < ApplicationRecord
  enum status: %i[waiting in_progress failed done]
  enum priority: %i[low critical high]
end
