class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :timeoutable

  validates :username, presence: true, length: { in: 2..20 }
  

  has_many :projects,  dependent: :destroy
  has_many :addresses, dependent: :destroy

  private

end
