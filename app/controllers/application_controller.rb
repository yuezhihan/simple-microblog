class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :prepare_data
  
  def prepare_data
    @logged_in = logged_in?
    @current_user = current_user
  end

  def hello
  	render html: "hello world!"
  end

  protected
    include LogConcern
end
