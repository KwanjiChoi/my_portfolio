module ReservationsHelper
  def reservations(user, is_owner: false, is_requester: false, status:)
    if is_requester == true
      Reservation.sort_reservations_by_status(user, requester: true, status: status)
    elsif is_owner == true
      Reservation.sort_reservations_by_status(user, owner: true, status: status)
    end
  end
end
