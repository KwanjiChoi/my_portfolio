module ReservationsHelper
  def show_status(reservation)
    case reservation.status

    when 'unchecked'
      '確認待ちです'
    when 'checked'
      '予定日までお待ちください'
    when 'finished'
      '終了しました'
    when 'canceled'
      'キャンセルしました'
    end
  end

  def show_minutes(sec)
    (sec / 60).to_i
  end
end
