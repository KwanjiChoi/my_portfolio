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

  def show_progress(reservation)
    case reservation.status

    when 'unchecked'
      '33'
    when 'checked'
      '66'
    when 'finished'
      '100'
    when 'canceled'
      '100'
    end
  end

  def progress_bar_color(reservation)
    reservation.status == 'canceled' ? 'bg-danger' : 'bg-success'
  end
end
