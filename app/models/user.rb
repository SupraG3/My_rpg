class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :players, dependent: :destroy

  validates :role, presence: true, inclusion: { in: %w[user admin] }

  before_validation :set_default_role, on: :create

  def admin?
    role == 'admin'
  end

  def user?
    role == 'user'
  end

  private

  def set_default_role
    self.role ||= 'user'
  end
end
