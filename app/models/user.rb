class User < ApplicationRecord
  authenticates_with_sorcery!
  
  validates :username, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

has_many :posts, dependent: :destroy

  def own?(object)
    id == object.user_id
  end
  
end
