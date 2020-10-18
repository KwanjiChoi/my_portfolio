class Address < ApplicationRecord
  MAX_LENGTH = 5
  belongs_to :user

  validates :address, presence: true, length: { maximum: 75 } 

  validate :check_number_of_addresses

  private

  def check_number_of_addresses
    if user && user.addresses.count >= MAX_LENGTH
      errors.add(:address, "は最大5件まで登録できます")
    end
  end

end
