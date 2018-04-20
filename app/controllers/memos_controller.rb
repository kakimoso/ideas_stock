class MemosController < ApplicationController
  before_action :logged_in_user, only: %i[create new show update]
  before_action :editable_memo?, only: %i[update]

  def new
    @memo = Memo.new
  end

  # ログイン中のユーザアカウントの最初のブックに新規メモを追加する
  def create
    @memo = current_user.books.first.memos.build(memo_params)
    if @memo.save
      redirect_to @memo.user
    else
      flash.now[:danger] = '保存に失敗しました'
      render 'new'
    end
  end

  # 編集されたメモを保存してユーザページに戻る
  def update
    @user = User.find_by(id: params[:user_id])
    if @memo.update_attributes(memo_params)
      redirect_to @user
    else
      flash[:danger] = '保存に失敗しました'
      redirect_to @user
    end
  end


  private

  # メモの持ち主を検証する
  def editable_memo?
    @memo = Memo.find_by(id: params[:id])
    @current_user = current_user
    @is_editable = (@memo.editable? || @memo.user == @current_user)
    unless @is_editable
      flash[:warning] = 'アクセスエラーが発生しました'
      redirect_to(@current_user)
    end
  end

  def memo_params
    params.require(:memo).permit(:title, :content, :edit_flag)
  end

end
