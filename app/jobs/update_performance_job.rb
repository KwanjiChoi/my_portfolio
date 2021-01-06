class UpdatePerformanceJob < ApplicationJob
  queue_as :default

  def perform
    User.teacher_accounts.each do |user|
      user.update_performance
    end

    Project.all.each do |project|
      next if project.reservations.empty?
      project.update_performance
    end
  end
end
