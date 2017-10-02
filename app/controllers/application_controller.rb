class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :prepare_data
  layout 'application'
  def hello
  	render html: "hello world!"
  end

  protected
    include LogConcern
    def prepare_data
      @logged_in = logged_in?
      @current_user = current_user
    end
end
