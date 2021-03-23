class UniqVisitsDecorator
  attr_reader :correct_data

  def initialize(correct_data)
    @correct_data = correct_data
  end

  def correct
    uniq_visits = correct_data.sort_by { |_key, value| value.uniq.length }.reverse.to_h
    uniq_visits.map { |key, value| uniq_visits[key] = value.uniq.length }
    uniq_visits
  end
end
