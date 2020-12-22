module DefineMethod::ReservationMethods
  extend ActiveSupport::Concern


  STATUS = Reservation.statuses.keys.freeze # ['unchecked', 'checked', 'finished', 'canceled']
  STATUS.each do |status|
    method_name = "#{status}_active_reservations"
    define_method method_name do |user|
      instance_variable_set("@#{method_name}",
                            Reservation.
                            sort_reservations_by_status(user, requester: true, status: status))
    end
  end

  STATUS.each do |status|
    method_name = "#{status}_passive_reservations"
    define_method method_name do |user|
      instance_variable_set("@#{method_name}",
                            Reservation.
                            sort_reservations_by_status(user, supplier: true, status: status))
    end
  end

  def reservation
    return nil if params[:id].blank?
    @reservation ||= Reservation.find(params[:id])
  end

  def requester
    @requester ||= reservation&.requester
  end

  def supplier
    @supplier ||= reservation.supplier
  end

  def project
    @project ||= Project.find(params[:project_id])
  end

  def new_reservation
    @new_reservation ||= Reservation.new
  end

  def message_room
    @message_room ||= Room.find_by(reservation: reservation)
  end
end
