class MemosController < ApplicationController
  before_action :logged_in_user, only: %i[create new show update]
  before_action :correct_user, only: %i[update]

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
    @memos = @user.memos.order(updated_at: :desc)
    begin
      @memo = @memos.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash.now[:danger] = 'メモが見つかりません'
      @memo = @memos.first
    end
    render template: 'users/show'
  end

  # 編集されたメモを保存してユーザページに戻る
  def update
    @user = memo_user
    @memo = @user.memos.find(params[:id])
    @memo.update_attributes(memo_params)
    if @memo.save
      show
    else
      flash.now[:danger] = '保存に失敗しました'
      show
    end
  end


  private

  # メモの持ち主を検証する
  def correct_user
    # ログイン中のユーザのメモか
    @memo = current_user.memos.find_by(id: params[:id])
    if @memo.nil?
      flash[:warning] = 'アクセスエラーが発生しました'
      redirect_to(memo_user)
    end
  end

  def memo_params
    params.require(:memo).permit(:title, :content)
  end

  # memoコントローラのメソッド実行時にログインしているユーザを返す
  def memo_user
    @user = current_user
  end
end
