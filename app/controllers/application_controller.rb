class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions
  before_action :authenticate_user!
  protect_from_forgery with: :exception
end
