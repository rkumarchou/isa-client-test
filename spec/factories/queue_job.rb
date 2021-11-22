# frozen_string_literal: true

FactoryBot.define do
  factory :queue_job do
    name { 'fake_job_1' }
    priority { 'low' }
  end
end
