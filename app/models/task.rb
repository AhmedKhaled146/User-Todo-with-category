class Task < ApplicationRecord
  belongs_to :category
  belongs_to :user

  validates :title, presence: true, uniqueness: { scope: :category_id, message: "Task title must be unique within the same category" }, length: { minimum: 3, maximum: 100 }

end
