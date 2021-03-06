 class FavoriteBook < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  validates_uniqueness_of :user_id, :scope => :book_id, :msg => "No duplicates entries allowed"
end