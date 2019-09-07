# frozen_string_literal: true

FactoryBot.define do
  factory :count do
    service_name { 'twitter' }
    count { 0 }
    limit { 1 }
  end
end
