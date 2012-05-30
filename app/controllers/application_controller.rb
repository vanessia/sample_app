class ApplicationController < ActionController::Base
  protect_from_forgery

  # By default, all the helpers are available in the views but not in the controllers
  # So if need to include explicitly
  include SessionsHelper 
end
