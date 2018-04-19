require 'rails_helper'

RSpec.feature 'Memos', type: :feature do
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
  scenario 'user can edit memo' do
    memo = FactoryGirl.create(:memo)
    other_memo = FactoryGirl.create(:memo, :other_memo, user: memo.user)
    user = memo.user

    escape_title = other_memo.title
    escape_content = other_memo.content
    edited_title = 'タイトル編集テスト'
    edited_content = '内容編集テスト'

    login_as user

    visit root_path
    click_link "マイページ / #{user.name}"

    # メモを１件編集する
    click_link display_title(memo.title)
    fill_in :memo_title, with: edited_title
    fill_in :memo_content, with: edited_content
    click_button '編集確定'

    click_link "マイページ / #{user.name}"
    click_link display_title(edited_title)
    expect(find_field(id: 'memo_title').value).to eq edited_title
    expect(find_field(id: 'memo_content').value).to eq edited_content

    # もう一件は編集されていないことを確認
    click_link display_title(other_memo.title)
    expect(find_field(id: 'memo_title').value).to eq escape_title
    expect(find_field(id: 'memo_content').value).to eq escape_content

  end

  # メモの公開・非公開・編集可否テスト
  scenario 'memo visible? and editable?' do
    # 他ユーザでログインし、ユーザのメモのアクセス制御をテストする
    user = FactoryGirl.create(:user)
    other_user = FactoryGirl.create(:user, :other_user)
    login_as other_user
    visit user_path(user)

    open_memo = user.memos.find_by_edit_flag(3)
    read_only_memo = user.memos.find_by_edit_flag(2)
    private_memo = user.memos.find_by_edit_flag(1)

    aggregate_failures do
      # 非公開メモは表示されていないこと
      expect(page).to have_content display_title(open_memo.title)
      expect(page).to have_content display_title(read_only_memo.title)
      expect(page).to_not have_content display_title(private_memo.title)

      click_link display_title(open_memo.title)
      expect(page).to have_css 'input', class: 'btn', visible: '編集確定'
      expect(page).to_not have_css 'select', id: 'memo_edit_flag'

      click_link display_title(read_only_memo.title)
      expect(page).to_not have_css 'input', class: 'btn', visible: '編集確定'
    end
  end

  def login_as(user)
    visit root_path
    click_link 'ログイン'
    fill_in 'ID', with: user.name
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
  end

  # タイトルが長い場合、短縮系にする
  def display_title(title)
    if title.length > 12
      title[0, 12] + '...'
    else
      title
    end
  end
end
