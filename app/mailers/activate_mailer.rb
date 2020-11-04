class ActivateMailer < ApplicationMailer
  def send_activate_teacher_account(user)
    @user = user
    mail to: user.email, subject: 'teacher機能をアクティベートしました'
  end
end
