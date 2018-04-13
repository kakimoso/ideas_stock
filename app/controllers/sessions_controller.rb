# ログイン系の処理を行う
class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(id: params[:session][:name])
    if @user && @user.authenticate(params[:session][:password])
      login @user
      redirect_to users_path(@user)
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      render 'new'
    end
  end
end
