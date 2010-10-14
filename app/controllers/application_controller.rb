class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # need to include SessionsHelper explicitly so it is avaliable in controllers
  # as well (by default it's avaliable in views already)
  include SessionsHelper
end
