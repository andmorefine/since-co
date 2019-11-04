# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_request_variant

  def index
    request.user_agent       #=> "Mozilla/5.0 (Macintosh; ..."
    request.device_type      #=> :pc
    request.os               #=> "Mac OSX"
    request.browser          #=> "Chrome"
    request.from_pc?         #=> true
    request.from_smartphone? #=> false
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def set_request_variant
    request.variant = request.device_variant # :pc, :smartphone
  end
end
