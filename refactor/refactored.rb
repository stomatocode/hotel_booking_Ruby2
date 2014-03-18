require 'csv'
require 'pry'
require 'pry-debugger'

module Reader
  def load_hotels_csv(filename)
    hotels = {}
    CSV.foreach(filename, :headers => true, :header_converters => :symbol) do |row|
      hotels[row[:name].downcase.to_sym] = row.to_hash
    end
    hotels
  end
end

module Booking
  def self.run
    @collection = Collection.new("hotels.csv")
    puts "Enter customer type (Regular or Rewards) and dates (DayMonYear format please):"
    @customer = Customer.new(get_input)
  end

  def get_input
    gets.chomp.gsub(/\W\s+|(\([a-z]*\)|,|\s)/, ' ').split(/\s/).reject(&:empty?)
  end
end


class Hotels
  include Reader

  attr_reader :hotels, :ratings, :rates

  def initialize(filename)
    @hotels = load_hotels_csv(filename)
    @rates = {}
  end

  def weekend?(day)
    day = day.split(/(\D{3,})/).reverse
    day = Time.utc(*day)
    return day.saturday? || day.sunday?
  end

  def get_rates(day_rate)
    @hotels.select {|key, value| @rates[key] = value[day_rate].to_i}
  end

  def best_rating(hotel1,hotel2)
    @hotels[hotel1][:rating] > @hotels[hotel2][:rating] ? @hotels[hotel1][:name] : @hotels[hotel2][:name]
  end

  def best_choice(day_rate)
    get_rates(day_rate)
    if @rates.values.sort[1] == @rates.values.min
      hotel1 = @rates.key(@rates.values.min)
      hotel2 = @rates.key(@rates.values.sort[1])
      return best_rating(hotel1,hotel2)
    else
      winner = @rates.key(@rates.values.min)
      p @hotels[winner][:name]
    end
  end

end

class Customer
  include Booking

  def initialize(parameters)
    @type = parameters[0]
    @dates = parameters[1..-1]
  end

  def find_hotel
    if type.downcase == "regular"
      dates[1..-1].each do |day|
        weekend?(day) ? best_choice(:regular_weekend) : best_choice(:regular_weekday)
      end
    elsif dates[0].downcase == "rewards"
      dates[1..-1].each do |day|
        weekend?(day) ? best_choice(:rewards_weekend) : best_choice(:rewards_weekday) 
      end
    else
      "invalid input"
    end
  end

end

Booking.run 



