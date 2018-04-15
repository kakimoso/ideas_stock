class MemosController < ApplicationController
  before_action :logged_in_user?, only: [:create, :new]

  def new
    @memo = Memo.new
  end

  def create
    @memo = memo_user.memos.build(memo_params)
    if @memo.save
      redirect_to @memo.user
    else
      flash.now[:danger] = '保存に失敗しました'
      render 'new'
    end
  end

  private

  def memo_params
    params.require(:memo).permit(:title, :content)
  end

  def memo_user
    @user = current_user
  end
end
