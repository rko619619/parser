class CorrectArgument
  attr_accessor :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  def check
    if !@file_path.nil?
      puts('A file is empty')
      if (File.extname(@file_path) == '.log') && File.exist?(@file_path)
        puts('A good file to work')
        true
      else
        false
      end
    else
      puts('Can you enter a correct file?')
      false
    end
  end
end

class ReadFile
  def initialize(file_path)
    @file_path = file_path
  end

  def read
    File.read(@file_path).split(/\n+/)
  end
end

class SplitData
  def initialize(file_read)
    @file_read = file_read
    @data = Hash.new([])
  end

  def correct_data
    @file_read.map { |x| x.split(' ') }.each do |var|
      @data[var[0]] += [var[1]]
    end
    @data
  end
end

class VisitsWebpage
  def initialize(correct_data)
    @correct_hash = Hash.new(0)
    @correct_data = correct_data
  end

  def correct
    @correct_data.each do |key, value|
      @correct_hash[key] += value.length
    end
    sort(@correct_hash)
  end

  private

  def sort(hash)
    sorted_hash = hash.sort_by { |_key, value| value }.reverse.to_h
    write(sorted_hash)
  end

  def write(sorted_hash)
    puts(sorted_hash.map { |key, value| "#{key} #{value} visits " }.join("\n"))
  end
end

class UniqVisits
  def initialize(correct_data)
    @correct_hash = Hash.new(0)
    @correct_data = correct_data
  end

  def correct
    @correct_data.each do |key, value|
      @correct_hash[key] += value.uniq.length
    end
    write(@correct_hash)
  end

  private

  def write(correct_hash)
    puts(correct_hash.map { |k, v| "#{k} #{v} unique views" })
  end
end

ARGV.each do |file_path|
  argv = CorrectArgument.new(file_path)
  next unless argv.check
  file = ReadFile.new(file_path)
  file_read = file.read
  data = SplitData.new(file_read)
  correct_data = data.correct_data
  visits = VisitsWebpage.new(correct_data)
  visits.correct
  uniq_visits = UniqVisits.new(correct_data)
  uniq_visits.correct
end
