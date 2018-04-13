class ApplicationController < ActionController::Base
  include SessionsHelper

  # デバッグ用メッセージフレーム
  def debugframe(message)
    puts "[debug_message] : #{message}"
  end

end
