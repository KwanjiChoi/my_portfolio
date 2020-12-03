class ReservationJob < ApplicationJob
  queue_as :default

  def perform(resevation)
    reservation.update_attribute(:status, finished)
    ActivateMailer.send_after_finished_reservation(reservation.require).deliver_now
  end
end
