class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production? # 本番環境のみBasic認証を行う

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

end
