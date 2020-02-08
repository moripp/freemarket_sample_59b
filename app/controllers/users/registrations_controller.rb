class Users::RegistrationsController < Devise::RegistrationsController
  # SNS認証してから新規登録をした場合は、パスワードを自動生成してcreateする
  def create
    if params[:sns_auth] == 'true'
      pass = Devise.friendly_token # パスワードを自動生成
      params[:user][:password] = pass
      params[:user][:password_confirmation] = pass
    end
    super # create実行後、通常通りdeviseでのcreateアクションが動く
  end
end
