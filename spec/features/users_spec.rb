require 'rails_helper'

RSpec.feature 'Users', type: :feature, focus: true do

  # ゲストは新規ユーザ登録ができる
  scenario 'guest can make new account' do
    user = FactoryGirl.build(:user)

    visit root_path
    click_link '新規登録'

    expect {
      fill_in 'ID', with: user.name
      fill_in 'パスワード', with: user.password
      fill_in 'パスワード(確認)', with: user.password_confirmation
      click_button '登録'
    }.to change(User, :count).by(1)
    expect(page).to have_content user.name
  end

  # ログインできる
  scenario 'user can login' do
    user = FactoryGirl.create(:user)

    visit root_path
    click_link 'ログイン'
    fill_in 'ID', with: user.name
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
    expect(page).to have_content user.name
  end

  # 自分の投稿を確認できる
  scenario 'user can check his post' do
    memo = FactoryGirl.create(:memo)
    user = memo.user
    login_as user
    click_link "マイページ / #{user.name}"
    expect(page).to have_content user.name
    expect(page).to have_content memo.title
    # ログインしてマイページ表示するまで

  end

  def login_as(user)
    visit root_path
    click_link 'ログイン'
    fill_in 'ID', with: user.name
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
  end

end
