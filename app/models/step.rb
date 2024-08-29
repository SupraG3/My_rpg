class Step < ApplicationRecord
  belongs_to :quest
  belongs_to :reward_item, class_name: 'Item', optional: true

  validates :description, presence: true
  validates :order, presence: true
  validates :question, presence: true
  validates :correct_answer, presence: true
  validates :wrong_answer, presence: true
end
