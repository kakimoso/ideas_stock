class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show]
  # before_action :correct_user, only: [:show]

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

  # ユーザページで選択されたメモを表示する
  def show
    @user = User.find(params[:id])
    @memos = @user.memos.order(updated_at: :desc)
    begin
      @memo = if !params[:memo_id].nil?
                @memos.find(params[:memo_id])
              else
                @memos.first
              end
    rescue ActiveRecord::RecordNotFound
      flash.now[:danger] = 'メモが見つかりません'
      @memo = @memos.first
    end
    @memo_is_editable = @memo.editable?(current_user) unless @memos.count.zero?
    render template: 'users/show'
  end

  private

  def user_params
    params.require(:user).permit(:name, :password,
                                 :password_confirmation)
  end

  def correct_user
    user = User.find(params[:id])
    unless user == current_user
      flash[:warning] = 'アクセスエラーが発生しました'
      redirect_to(current_user)
    end
  end

end
