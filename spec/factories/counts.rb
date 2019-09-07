# frozen_string_literal: true

FactoryBot.define do
  factory :count do
    name { 'MyString' }
    count { 1 }
    limit { 1 }
  end
end
