class ActivateTeacherJob < ApplicationJob
  queue_as :default

  def perform(user)
    user.activate_teacher
    ActivateMailer.send_activate_teacher_account(user).deliver_now
  end
end
