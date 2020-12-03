class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :entries,  dependent: :destroy

  belongs_to :reservation

  def mate?(user)
    if user != reservation.supplier && user != reservation.requester
      false
    end
  end

  def opponent(user)
    user == reservation.requester ? reservation.supplier.username : reservation.requeser.username
  end
end
