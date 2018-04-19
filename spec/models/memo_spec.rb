require 'rails_helper'

RSpec.describe Memo, type: :model do
  # 有効なファクトリを持つこと
  it 'has a valid factory' do
    memo = FactoryGirl.create(:memo)
    expect(memo).to be_valid
  end

  # ユーザに紐づいていること
  it 'have user information' do
    memo = FactoryGirl.create(:memo)
    user = memo.user
    expect(user).to be_valid
  end

  # 編集フラグは1~3のみ有効であること
  it 'is valid memo which edit_flag is valid num' do
    user = FactoryGirl.create(:user)
    memo_0 = FactoryGirl.build(:memo, edit_flag: 0, user: user)
    memo_1 = FactoryGirl.build(:memo, edit_flag: 1, user: user)
    memo_2 = FactoryGirl.build(:memo, edit_flag: 2, user: user)
    memo_3 = FactoryGirl.build(:memo, edit_flag: 3, user: user)
    memo_4 = FactoryGirl.build(:memo, edit_flag: 4, user: user)
    memo_a = FactoryGirl.build(:memo, edit_flag: 'a', user: user)
    valids = [memo_1, memo_2, memo_3]
    invalids = [memo_0, memo_4, memo_a]
    memo_a.edit_flag = 'aaa'
    valids.each do |v|
      expect(v).to be_valid
    end
    invalids.each do |i|
      expect(i).to_not be_valid
    end
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
