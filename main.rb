require 'thread'

class FileWriter
  def initialize(file_name)
    @file_name = file_name
    @mutex = Mutex.new
  end

  def write_data(data)
    @mutex.synchronize do
      File.open(@file_name, 'a') do |file|
        file.puts(data)
      end
    end
  end
end

file_writer = FileWriter.new('shared_file.txt')

threads = []

3.times do |i|
  threads << Thread.new do
    file_writer.write_data("Дані з потоку #{i + 1}")
  end
end

threads.each(&:join)

puts "Запис завершено."





