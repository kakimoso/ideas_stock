require 'rails_helper'

RSpec.describe 'UsersApis', type: :request, focus: true do
  describe 'invalid pattern' do
    before do
      @memo = FactoryGirl.create(:memo)
      @user = @memo.user
      @other_memo = FactoryGirl.build(:memo, :other_memo, user: @memo.user)
    end

    # 非ログイン時のアクセス無効テスト
    it 'invalid when not logged in' do
      # 新規メモ(new)
      get new_memo_path
      aggregate_failures do
        expect(response).to_not be_success
        expect(response).to have_http_status(302)
      end

      # メモ作成(create)
      post memos_path, params: {
        memo: {
          title: @other_memo.title,
          content: @other_memo.content
        } }
      aggregate_failures do
        expect(response).to be_success
        expect(response).to have_http_status(302)
      end

      # ユーザプロフィール(show)
      get user_path(@user)
      aggregate_failures do
        expect(response).to_not be_success
        expect(response).to have_http_status(302)
      end
    end

    # ログイン時のアクセス無効テスト
    it 'invalid when logged in' do
      login
      @other_memo.user = FactoryGirl.create(:user, :other_user)
      @other_memo.save

      # 他ユーザのメモ編集(update)
      patch memo_path(@other_memo), params: { id: @memo.id }
      aggregate_failures do
        expect(response).to_not be_success
        expect(response).to have_http_status(302)
      end
    end

    def login
      post login_path, params: { session: {
        name: @user.name,
        password: @user.password,
        password_confirmation: @user.password
      } }
    end
  end
end
