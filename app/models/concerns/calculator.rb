module Calculator
  extend ActiveSupport::Concern

  def update_performance
    return if performance.nil?
    performance.update(average_score: calculate_average_score,
                       total_record: get_finished_record)
  end

  private

  def calculate_average_score
    return nil if comments.empty?
    comments.average(:score).to_f.floor(2)
  end
end