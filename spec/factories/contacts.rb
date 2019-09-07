# frozen_string_literal: true

FactoryBot.define do
  factory :contact do
    name { 'MyString' }
    email { 'MyString' }
    phone_number { 'MyString' }
    subject { 'MyString' }
    body { 'MyString' }
  end
end
