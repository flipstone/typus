class Typus::SessionController < Typus::BaseController

  skip_before_filter :reload_config_and_roles
  skip_before_filter :authenticate

  before_filter :create_an_account?, :only => [:new, :create]

  def new
  end

  def create
    user = Typus.user_class.authenticate(params[:typus_user][:email], params[:typus_user][:password])

    path = if user
             session[:typus_user_id] = user.id
             params[:back_to] || typus_dashboard_path
           else
             new_typus_session_path(:back_to => params[:back_to])
           end

    redirect_to path
  end

  def destroy
    deauthenticate
  end

  private

  def create_an_account?
    redirect_to new_typus_account_path if Typus.user_class.count.zero?
  end

  def set_locale
    I18n.locale = I18n.default_locale
  end

end
