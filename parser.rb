file_path = ARGV

if file_path[0].nil?
  puts('You idiot')
else
  if File.extname(file_path[0]) == '.log' and File.exist?(file_path[0])
    puts("Done")
  else
    puts('Can you repeat')
  end
end

result = File.read(file_path[0]).split(/\n+/)

data = Hash.new([])
result.map {|x| x.split(' ')}.each do |mass|
  data[mass[0]] += [mass[1]]
end

data1 = Hash.new(0)
data.each do |key, value|
  data1[key] += value.length
end
sorted_hash = data1.sort_by { |_key, value| value }.reverse.to_h
puts(sorted_hash.map { |k, v| "#{k} #{v} visits " }.join("\n"))


data2 = Hash.new(0)
data.each do |key, value|
  data2[key] += value.uniq.length
end

puts("=======================================================================================================")

puts(sorted_hash.map { |k, v| "#{k} #{v} unique views" })


