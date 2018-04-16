class MemosController < ApplicationController
  before_action :logged_in_user?, only: [:create, :new]

  def new
    @memo = Memo.new
  end

  # ログイン中のユーザアカウントに新規メモを追加する
  def create
    @memo = memo_user.memos.build(memo_params)
    if @memo.save
      redirect_to @memo.user
    else
      flash.now[:danger] = '保存に失敗しました'
      render 'new'
    end
  end

  # ユーザページで選択されたメモを編集可能にする
  def show
    @user = memo_user
    @memos = @user.memos.all
    @memo = @memos.find(params[:id])
    render template: 'users/show'
  end

  private

  def memo_params
    params.require(:memo).permit(:title, :content)
  end

  # create実行時にログインしているユーザを返す
  def memo_user
    @user = current_user
  end
end
