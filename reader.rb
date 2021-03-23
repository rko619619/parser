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
