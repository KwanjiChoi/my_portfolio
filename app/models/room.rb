class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :entries,  dependent: :destroy

  belongs_to :reservation

  def mate?(user)
    user == reservation.supplier || user == reservation.requester
  end

  def opponent(user)
    user == reservation.requester ? reservation.supplier.username : reservation.requester.username
  end
end
