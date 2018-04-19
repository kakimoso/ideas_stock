FactoryGirl.define do
  factory :book do
    name "test book"
    association :user, factory: :user
    memo_id { [FactoryGirl.create(:book_memo)] }
  end

  factory :parent_book, class: :book do
    name "parent book"
    association :user, factory: :user
  end

  factory :sub_book, class: :book do
    name "sub book"
    memo_id { [FactoryGirl.create(:book_memo)] }
  end

end
