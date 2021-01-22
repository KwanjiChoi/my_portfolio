class ReservationDecorator < ApplicationDecorator
  delegate_all

  def start_at
    object.start_at.strftime('%Y/%m/%d %H:%M')
  end

  def show_reserve_time
    "#{((object.end_at - object.start_at) / 60).to_i}分"
  end

  def owner_name
    object.project.owner
  end
end
