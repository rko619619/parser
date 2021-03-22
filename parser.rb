class Validator
  attr_reader :file_path

  EXPAN = ['.log'].freeze

  def initialize(file_path)
    @file_path = file_path
  end

  def check?
    if file_present? && extname? && exist?
      true
    else
      puts('Can you enter a correct file?')
      false
    end
  end

  private

  def file_present?
    !file_path.nil?
  end

  def exist?
    File.exist?(file_path)
  end

  def extname?
    EXPAN.include?(File.extname(file_path))
  end
end

class Reader
  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  def read
    File.readlines(file_path)
  end
end

class Spliter
  attr_reader :file_read, :data

  def initialize(file_read)
    @file_read = file_read
    @data = Hash.new([])
  end

  def correct_data
    file_read.map { |x| x.split(' ') }.each do |var|
      data[var[0]] += [var[1]]
    end
    data
  end
end

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

if ARGV[0]
  argv = Validator.new(ARGV[0])
  argv.check?
  file = Reader.new(ARGV[0])
  file_read = file.read
  data = Spliter.new(file_read)
  correct_data = data.correct_data
  visits = VisitsDecorator.new(correct_data).correct
  Printer.new(visits, 'Visits').printer
  uniq_visits = UniqVisitsDecorator.new(correct_data).correct
  Printer.new(uniq_visits, 'Uniq visits').printer
else
  raise ArgumentError
end
