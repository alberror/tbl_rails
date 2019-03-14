class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def locale_switch
    redirect_to "/#{I18n.locale}/"
  end

  def home
    @home = true
  end

  def terms
    @title = t 'terms.title'
  end
end
