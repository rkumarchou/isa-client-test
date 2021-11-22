# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::QueueJobsController do
  describe 'GET /api/v1/jobs' do
    context 'with list jobs' do
      let!(:incomplete_job) { create(:queue_job) }
      it 'returns unauthorized' do
        get :index

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
# To do other scenario i.e listing jobs with authentication.
