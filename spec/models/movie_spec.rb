# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe '#run' do
    context 'when #run' do
      it 'is create movie' do
        Movie.run

        expect(Movie.count).not_to eq nil
      end
    end
  end
end
