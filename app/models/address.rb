class Address < ApplicationRecord
  MAX_LENGTH = 5
  SHOW_INDEX_LENGTH = 5

  belongs_to  :user

  geocoded_by :address

  after_validation :geocode, if: :address_changed?
  after_validation :check_correct_address
  validates        :address, presence: true,
                             length: { maximum: 75 },
                             max_count: { belongs_to: 'User', count: MAX_LENGTH }

  scope :show_index, -> {
    order(id: :desc).limit(SHOW_INDEX_LENGTH)
  }

  private

  def check_correct_address
    if latitude.nil? || longitude.nil?
      errors.add(:address, 'は無効な住所です')
    end
  end
end
