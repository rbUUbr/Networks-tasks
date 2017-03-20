module ParseMethods
  def make_hash_from_data(data)
    data.each_index do |index|
      @data[data[index]] = data[index +1 ] if index.even?
    end
  end
  def parse_data(data)
    data = data.split(/[?]|[=]/)
    data = data.select {|element| (element != '&' && element != '?' && element != '=')}
  end
  def input_user_info
    send(@type_of_inputs, "Please, put username for #{@url}".colorize(:magenta))
    @username = STDIN.gets.chomp
    send(@type_of_inputs, "Please, input password for #{@url}".colorize(:magenta))
    @password = STDIN.gets.chomp
  end
end