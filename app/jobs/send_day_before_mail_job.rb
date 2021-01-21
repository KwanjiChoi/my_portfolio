class SendDayBeforeMailJob < ApplicationJob
  queue_as :slow

  def perform
    Reservation.where(
      start_at: Time.zone.tomorrow.beginning_of_day..Time.zone.tomorrow.end_of_day
    ).each do |reservation|
      ReservationMailer.send_day_before_mail(reservation).deliver_now
    end
  end
end
