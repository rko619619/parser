require_relative 'validator'
require_relative 'reader'
require_relative 'spliter'
require_relative 'visits_decorator'
require_relative 'uniqvisits_decorator'
require_relative 'printer'

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
