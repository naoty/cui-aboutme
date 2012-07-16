class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from Mongoid::Errors::DocumentNotFound, with: :error_404

  private

  def error_404
    render '404'
  end
end
