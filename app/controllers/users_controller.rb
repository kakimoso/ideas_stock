class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @book = @user.books.build(name: 'デフォルト')
    if @user.save && @book.save
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
    local_cur_user = current_user

    # bookを送る
    @books = @user.books.order(updated_at: :desc).clone

    # @booksのmemosの表示を選別する
    @books.each do |b|
      b.memos = if @user == local_cur_user
                  b.memos.order(updated_at: :desc)
                else
                  b.memos.where.not(edit_flag: 1).order(updated_at: :desc)
                end
    end

    @memos = if @user == local_cur_user
               @user.books.first.memos.order(updated_at: :desc)
             else
               @user.books.first.memos.where.not(edit_flag: 1).order(updated_at: :desc)
             end

    begin
      if !@memos.nil? && !@memos.count.zero?
        @memo = if params[:memo_id].nil?
                  @memos.first
                else
                  @memos.find(params[:memo_id])
                end
        @memo_is_editable = @memo.editable?(local_cur_user)
      end
    rescue ActiveRecord::RecordNotFound
      flash.now[:warning] = 'メモが見つかりません'
      @memo = @memos.first
    end

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
