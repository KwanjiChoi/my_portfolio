class ReservationMailer < ApplicationMailer
  def send_day_before_mail(reservation)
    @reservation = reservation
    mail to: reservation.requester, subject: '明日の予約を確認してください！'
  end
end
