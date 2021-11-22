class Movie < ApplicationRecord
  class << self
    def run
      create(title: random_title)
    end

    def random_title
      (0...9).map { (65 + rand(26)).chr }.join
    end
  end
end
