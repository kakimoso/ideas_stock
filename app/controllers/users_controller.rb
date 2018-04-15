class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def update; end

  def show
    @user = User.find(params[:id])
    @memos = @user.memos.all
  end

  private

  def user_params
    params.require(:user).permit(:name, :password,
                                 :password_confirmation)
  end

end
