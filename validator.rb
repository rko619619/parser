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
