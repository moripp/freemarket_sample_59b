class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_params_if_authentication_sns, only: [:create]

  def new
    @user = User.new
  end
  
  def create
  private
  def configure_params_if_authentication_sns
    # SNS認証してから新規登録をした場合は、パスワードを自動生成してparamsに入れる
    if params[:sns_auth] == 'true'
      pass = Devise.friendly_token # パスワードを自動生成
      params[:user][:password] = pass
      params[:user][:password_confirmation] = pass
    end
  end
  end
end
