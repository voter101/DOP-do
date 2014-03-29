class ApplicationController < ActionController::Base
  before_filter :authenticate_user!

  def index
    render 'index'
  end

  protected
  def confirmation_required?
    !confirmed?
  end

  protected
  def after_sign_in_path_for(resource)
    '/'
  end

end
