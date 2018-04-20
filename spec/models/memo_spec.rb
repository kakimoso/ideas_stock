require 'rails_helper'

RSpec.describe Memo, type: :model do

  # ユーザに紐づいていること
  it 'have user information' do
    memo = FactoryGirl.create(:memo)
    user = memo.user
    expect(user).to be_valid
  end

  it 'ブックに紐づいていなければ無効であること' do
    memo = FactoryGirl.create(:memo)
    memo.book_id = nil
    expect(memo).to_not be_valid
  end

  it '編集ステータスは1, 2, 3のみ有効であること' do
    # user = FactoryGirl.create(:user, :with_emp_book)
    memo = FactoryGirl.create(:book_memo, edit_flag: 3)
    expect(memo).to be_valid
  end

  describe '#title' do
    # タイトルがなければ無効であること
    it { is_expected.to validate_presence_of :title }

    # タイトルが長すぎる場合無効であること
    it {
      is_expected.to validate_length_of(:title)
        .is_at_most(25)
    }
  end

  describe '#content' do
    # 内容はなくても有効であること
    it { is_expected.to_not validate_presence_of :content }
  end
end
