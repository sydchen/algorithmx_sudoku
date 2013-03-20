SAMPLE_INPUT = []
File.open(File.join(Rails.root, 'config/sample_input.txt')) do |f|
  f.each_line { |line| SAMPLE_INPUT << line.strip.split(',').map(&:to_i) }
end
