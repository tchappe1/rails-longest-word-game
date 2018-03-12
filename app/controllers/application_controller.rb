class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  SCORE = 0
end
