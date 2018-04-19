require 'rails_helper'

RSpec.describe 'MemosApis', type: :request do
  xdescribe 'GET /memos_apis' do
    before do
      @memo = FactoryGirl.create(:memo)
      @user = @memo.user
      @other_memo = FactoryGirl.build(:memo, :other_memo, user: @memo.user)
    end

    # 他人のメモ編集テスト
    context "edit memo isn't owned editor" do
      it 'valid editing public memo' do
        login
        private_user = FactoryGirl.create(:private_user)
        public_memo = private_user.memos.find_by(edit_flag: 3)

        patch memo_path(public_memo),
              params: {
                id: public_memo.id,
                user_id: private_user.id,
                memo: {title: 'test', content: 'test', edit_flag: 3}
              }
        expect(response).to render_template('/users/show')
      end

      it 'invalid editing read only memo' do
        login
        private_user = FactoryGirl.create(:private_user)
        read_only_memo = private_user.memos.find_by(edit_flag: 2)
        patch memo_path(read_only_memo),
              params: {
                id: read_only_memo.id,
                user_id: private_user.id,
                memo: FactoryGirl.attributes_for(:memo)
              }
        aggregate_failures do
          expect(response).to_not be_success
          expect(response).to have_http_status(302)
        end
      end

      it 'invalid editing private memo' do
        login
        private_user = FactoryGirl.create(:private_user)
        private_memo = private_user.memos.find_by(edit_flag: 1)
        patch memo_path(private_memo),
              params: {
                id: private_memo.id,
                user_id: private_user.id,
                memo: FactoryGirl.attributes_for(:memo)
              }
        aggregate_failures do
          expect(response).to_not be_success
          expect(response).to have_http_status(302)
        end
      end
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
