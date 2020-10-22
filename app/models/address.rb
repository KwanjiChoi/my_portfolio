class Address < ApplicationRecord
  MAX_LENGTH = 5
  SHOW_INDEX_LENGTH = 5

  belongs_to  :user

  geocoded_by :address


  after_validation :geocode, if: :address_changed?
  after_validation :check_correct_address
  validates        :address, presence: true, length: { maximum: 75 }
  validate         :check_number_of_addresses


  scope :show_index, -> {
    order(id: :desc).limit(SHOW_INDEX_LENGTH)
  }

  private

  def check_number_of_addresses
    if user && user.addresses.count >= MAX_LENGTH
      errors.add(:address, "の登録は最大5件までです")
    end
  end

  def check_correct_address
    if latitude == nil || longitude == nil
      errors.add(:address, 'は無効な住所です')
    end
  end

end
