class Printer
  attr_reader :data, :description

  def initialize(data, description)
    @data = data
    @description = description
  end

  def printer
    data.map do |key, value|
      puts("#{key} - #{value} #{description}")
    end
  end
end
