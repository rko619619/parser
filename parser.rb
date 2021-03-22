class Validator
  attr_reader :file_path

  EXPAN = ['.log']

  def initialize(file_path)
    @file_path = file_path
  end

  def check
    if nil_file && extname && exist
      true
    else
      puts('Can you enter a correct file?')
      false
    end
  end

  private

  def nil_file
    !file_path.nil?
  end

  def exist
    File.exist?(file_path)
  end

  def extname
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
    visits = correct_data.sort_by { |key, value| value.length }.reverse.to_h
    write(visits)
  end

  private

  def write(sorted_hash)
    puts(sorted_hash.map { |key, value| "#{key} #{value.length} visits " }.join("\n"))
  end
end

class UniqVisitsDecorator
  attr_reader :correct_data
  def initialize(correct_data)
    @correct_data = correct_data
  end

  def correct
    uniq_visits = correct_data.sort_by { |key, value| value.uniq.length }.reverse.to_h
    write(uniq_visits)
  end

  private

  def write(correct_hash)
    puts(correct_hash.map { |key, value| "#{key} #{value.uniq.length} unique views" })
  end
end


ARGV.each do |file_path|
  argv = Validator.new(file_path)
  next unless argv.check
  file = Reader.new(file_path)
  file_read = file.read
  data = Spliter.new(file_read)
  correct_data = data.correct_data
  visits = VisitsDecorator.new(correct_data)
  visits.correct
  uniq_visits = UniqVisitsDecorator.new(correct_data)
  uniq_visits.correct
end
