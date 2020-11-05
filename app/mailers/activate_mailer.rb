class ActivateMailer < ApplicationMailer
  def apply_teacher_account(user)
    @user = user
    mail to: user.email, subject: 'teacherアカウントの申請を受け付けました'
  end

  def send_activate_teacher_account(user)
    @user = user
    mail to: user.email, subject: 'teacher機能をアクティベートしました'
  end
end
