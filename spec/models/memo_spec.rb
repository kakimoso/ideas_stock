require 'rails_helper'

RSpec.describe Memo, type: :model do
  # ファクトリが正しく設定されていること
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

  describe '#title' do

    # タイトルがなければ無効であること
    it { is_expected.to validate_presence_of :title }

    # タイトルが長すぎる場合無効であること
    it {
      is_expected.to validate_length_of(:title)
        .is_at_most(50)
        .with_message('50文字以内で入力してください')
    }
  end

  describe '#content' do
    # 内容はなくても有効であること
    it { is_expected.to_not validate_presence_of :content }
  end

end
