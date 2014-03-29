class ApplicationController < ActionController::Base
  before_filter :authenticate_user!

  def index
    render 'index'
  end
end
