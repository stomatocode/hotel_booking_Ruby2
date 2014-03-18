require 'optparse'

require 'csv'
require 'pry'
require 'pry-debugger'

##Operations/IO

module Reader

  # make Reader responsible for taking input
  # reading from hotels data file
  # 

  def load_hotels_csv(filename)
    hotels = {}
    CSV.foreach(filename, :headers => true, :header_converters => :symbol) do |row|
      hotels[row[:name].downcase.to_sym] = Hotel.new(row)
    end
    hotels
  end

  def inputs
    parameters = ""
    while parameters == ""
        parameters = gets.chomp
        parameters = parameters.gsub(/\W\s+|(\([a-z]*\)|,)/, ' ')
        choices = parameters.split(/\s+|(\([a-z]*\)|,)/)  
    end
    choices
  end

  def to_hash
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete("@")] = instance_variable_get(var) }
    hash
  end

end

##Hotel

class Hotel
  extend Reader

  attr_reader :name, :rating, :regular_weekday, :regular_weekend, :rewards_weekday, :rewards_weekend

  def initialize(hotel)
    @name            = hotel[:name]
    @rating          = hotel[:rating]
    @regular_weekday = hotel[:regular_weekday]
    @regular_weekend = hotel[:regular_weekend]
    @rewards_weekday = hotel[:rewards_weekday]
    @rewards_weekend = hotel[:rewards_weekend]
  end

  def cheapest(hotels)

    hotels.each_value do |hotel|
      rates << hotel[]
    end
  end

end




options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: example.rb [options]"

  opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
    options[:verbose] = v
  end
end.parse!

p options
p ARGV