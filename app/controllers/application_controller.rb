class ApplicationController < ActionController::Base
  # デバッグ用メッセージフレーム
  def debugframe(message)
    puts "[debug_message] : #{message}"
  end
end
