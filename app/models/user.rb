class User < ApplicationRecord
  VALID_PHONE_REGEX = /\A\d{10}$|^\d{11}\z/

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :timeoutable, :omniauthable

  validates :username, presence:   true,
                       uniqueness: { case_sensitive: :false },
                       length:     { in: 2..20 }

  validates :phone_number, uniqueness:  { case_sensitive: :false },
                           allow_nil:   true

  after_validation :check_correct_number

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
        email: User.dummy_email(auth),
        username: auth.info.name,
        password: Devise.friendly_token[0, 20],
        # image:  auth.info.image
      )
      user.skip_confirmation!
      user.save
    end
    user
  end

  def self.dummy_email(auth)
    auth.info.email || "#{auth.uid}-#{auth.provider}@example.com"
  end

  def activate_teacher
    update_attribute(:teacher, true)
  end

  private

  def check_correct_number
    return if phone_number.nil?
    unless phone_number.match VALID_PHONE_REGEX
      errors.add(:phone_number, 'type correct phone number' )
    end
  end
end
