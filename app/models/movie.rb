class Movie < ApplicationRecord
  class << self
    def random_title
      (0...9).map { (65 + rand(26)).chr }.join
    end
  end
end
