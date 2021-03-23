class VisitsDecorator
  attr_reader :correct_data

  def initialize(correct_data)
    @correct_data = correct_data
  end

  def correct
    visits = correct_data.sort_by { |_key, value| value.length }.reverse.to_h
    visits.map { |key, value| visits[key] = value.length }
    visits
  end
end
