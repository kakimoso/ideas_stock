# ログイン系の処理を行う
class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(id: params[:session][:name])
    debugframe @user.name
    if @user && @user.authenticate(params[:session][:password])
      debugframe 'ユーザ判別成功'
      login @user
      redirect_to users_path(@user)
    else
      debugframe 'ユーザ判別失敗'
      flash.now[:danger] = 'ログインに失敗しました。'
      render 'new'
    end
  end
end
