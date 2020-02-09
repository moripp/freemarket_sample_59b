# SNS認証に関する処理を担当するcontroller
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    authorization
  end

  def google_oauth2
    authorization
  end

  def failure
    redirect_to root_path
  end

  private
  def authorization
    sns_info = User.from_omniauth(request.env["omniauth.auth"]) # APIから受け取ったレスポンスがrequest.env["omniauth.auth"]に入っている
    @user = sns_info[:user]

    if @user.persisted? # ユーザー情報が登録済みの時は新規登録ではなくログイン処理を行う
      sign_in_and_redirect @user, event: :authentication
    else # ユーザー情報が未登録の時は、新規登録画面へ遷移
      @sns_id = sns_info[:sns].id
      render template: 'devise/registrations/new'
    end
  end
end
