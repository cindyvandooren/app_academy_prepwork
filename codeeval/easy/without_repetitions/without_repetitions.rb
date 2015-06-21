
def without_repetitions(file)
  content = File.read(file)
  puts remove_repetitions(content)
end

def remove_repetitions(content)
  new_content = []
  arr = content.split("")
  arr.each_with_index do |l, index|
    if index < content.size
      if l != content[index+1]
        new_content << l
      end
    end
  end
  new_content.join("")
end

if __FILE__ == $PROGRAM_NAME
  if ARGV.empty?
    without_repetitions("without_repetitions.txt")
  else
    without_repetitions("#{ARGV[0]}")
  end
end


