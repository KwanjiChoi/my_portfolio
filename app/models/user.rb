class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :timeoutable, :omniauthable

  validates :username, presence: true, length: { in: 2..20 }

  has_many :projects,  dependent: :destroy
  has_many :addresses, dependent: :destroy

  def available_addresses
    5 - addresses.count
  end

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.new(
        uid: auth.uid,
        provider: auth.provider,
        email: auth.info.email,
        username: auth.info.name,
        password: Devise.friendly_token[0, 20],
        # image:  auth.info.image
      )
      user.skip_confirmation!
      user.save
    end
    user
  end
end
