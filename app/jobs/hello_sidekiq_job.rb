class ScoreCulcurateJob < ApplicationJob
  queue_as :default

  def perform(*args)
    users = User.where(teacher: true)
  end
end
