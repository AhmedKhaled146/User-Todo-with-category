class Category < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :user_id, message: "Category name must be unique per user" }, length: { minimum: 3, maximum: 50 }

end
