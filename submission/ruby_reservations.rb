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
    collection = Collection.new("hotels.csv")
    collection.find_hotel(get_input)
  end

  def self.get_input
    puts "Enter customer type (Regular or Rewards) and dates (DayMonYear format please):"
    gets.chomp.gsub(/\W\s+|(\([a-z]*\)|,|\s)/, ' ').split(/\s/).reject(&:empty?)
  end
end


class Collection
  include Reader
  include Booking

  attr_reader :hotels, :ratings, :rates

  def initialize(filename)
    @hotels = load_hotels_csv(filename)
    @rates = {}
  end

  def find_hotel(parameters)
    if parameters[0].downcase == "regular" 
      parameters[1..-1].each do |day|
        weekend?(day) ? best_choice(:regular_weekend) : best_choice(:regular_weekday)
      end
    elsif parameters[0].downcase == "rewards"
      parameters[1..-1].each do |day|
        weekend?(day) ? best_choice(:rewards_weekend) : best_choice(:rewards_weekday) 
      end
    else
      p "invalid input"
    end
  end

  def weekend?(day)
    day = day.split(/(\D{3,})/).reverse
    day = Time.utc(*day)
    return day.saturday? || day.sunday?
  end

  def blackout?(date)
    date == "25Dec2014"
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

# Booking.run 



