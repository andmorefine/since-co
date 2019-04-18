# frozen_string_literal: true

require 'rails_helper'

module ControllerMacros
  def login_admin
    @request.env['devise.mapping'] = Devise.mappings[:member]
    admin = Member.create(email: 'admin@admin.com', password: '111111')
    sign_in admin
  end
end
