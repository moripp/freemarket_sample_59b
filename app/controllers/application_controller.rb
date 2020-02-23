class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production? # 本番環境のみBasic認証を行う
  before_action :configure_permitted_parameters, if: :devise_controller? # devise経由でusersに変更がある場合に実行

  private

  # 本番環境ならtrueを返すメソッド
  def production?
    Rails.env.production?
  end

  # Basic認証のメソッドを定義、実際のユーザー名とパスワードは環境変数に記載
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  # deviseデフォルトで許可しているkey以外を許容するための記載
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name_sei, :name_mei, :kana_sei, :kana_mei, :birth_date, :nickname])
  end

  # サインインしてない時はログイン画面へ遷移させる
  def move_to_Log_in
    redirect_to new_user_session_path unless user_signed_in?
  end
end
