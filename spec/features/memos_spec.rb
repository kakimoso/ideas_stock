require 'rails_helper'

RSpec.feature 'Memos', type: :feature, focus: true do
  # ユーザはメモを投稿することができる
  scenario 'user can post memo' do
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

  # ユーザは投稿したメモを編集することができる
  scenario 'user can post memo' do
    memo = FactoryGirl.create(:memo)
    other_memo = FactoryGirl.create(:memo, :other_memo, user: memo.user)
    escape_title = other_memo.title
    escape_content = other_memo.content
    user = memo.user
    editted_title = 'タイトル編集テスト'
    editted_content = '内容編集テスト'

    login_as user

    visit root_path
    click_link "マイページ / #{user.name}"

    # メモを１件編集する
    click_link memo.title
    fill_in :memo_title, with: editted_title
    fill_in :memo_content, with: editted_content
    click_button '編集確定'

    click_link "マイページ / #{user.name}"
    click_link editted_title
    expect(page).to have_content editted_title
    expect(page).to have_content editted_content

    # もう一件は編集されていないことを確認
    click_link other_memo.title
    expect(page).to have_content escape_title
    expect(page).to have_content escape_content
  end

  def login_as(user)
    visit root_path
    click_link 'ログイン'
    fill_in 'ID', with: user.name
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
  end
end
