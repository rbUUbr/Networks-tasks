module ParseMethods
  def make_hash_from_data(data)
    data.each_index do |index|
      @options[:data][data[index]] = data[index +1 ] if index.even?
    end
  end
  def parse_data(data)
    data = data.split(/([?]|[=])/)
    data = data.select {|element| (element != '&' && element != '?' && element != '=')}
    return data
  end
end