class QueueJob < ApplicationRecord
  enum status: %i[waiting in_progress failed completed]
  enum priority: %i[low critical high]
end
