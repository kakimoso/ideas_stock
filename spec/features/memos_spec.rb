require 'rails_helper'

RSpec.feature 'Memos', type: :feature do
  # ユーザはメモを投稿することができる
  scenario 'user can post memo and display at mypage' do
    memo = FactoryGirl.build(:memo)
    user = memo.user
    login_as user

    expect  do
      visit root_path
      click_link '新規メモ'
      fill_in :memo_title, with: memo.title
      fill_in :memo_content, with: memo.content
      click_button '完了'
    end.to change(Memo, :count).by(1)
  end

  def login_as(user)
    visit root_path
    click_link 'ログイン'
    fill_in 'ID', with: user.name
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
  end
end
