require 'csv'

##Operations/IO

module Reader

  def load_hotels_csv(filename)
    hotels = {}
    CSV.foreach(filename, :headers => true, :header_converters => :symbol) do |row|
      hotels[row[:name].downcase.to_sym] = Hotel.new(row).to_hash
    end
    p hotels
  end

  def self.inputs
    parameters = gets.chomp.gsub(/\W\s+|(\([a-z]*\)|,|\s)/, ' ').split(/\s/).reject!(&:empty?)
  end

  def self.to_hash
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete("@")] = instance_variable_get(var) }
    hash
  end

  def to_hash
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete("@")] = instance_variable_get(var) }
    hash
  end

  def self.rewards(index)
    rewards = {}
    index.each_value do |hotel|
      hotel = hotel.to_hash
      hotel.each_pair do |key, value|
        rewards[key] = value
      end
    end
    rewards  
  end

  def self.regular(index)
    regular = {}
    index.each_value do |hotel|
      hotel = hotel.to_hash
      hotel.each_pair do |key, value|
        regular[key] = value
      end
    end
    regular
  end

end

##Hotel

class Hotel

  attr_reader :name, :rating, :regular_weekday, :regular_weekend, :rewards_weekday, :rewards_weekend

  def initialize(hotel)
    @name            = hotel[:name]
    @rating          = hotel[:rating]
    @regular_weekday = hotel[:regular_weekday]
    @regular_weekend = hotel[:regular_weekend]
    @rewards_weekday = hotel[:rewards_weekday]
    @rewards_weekend = hotel[:rewards_weekend]
  end

  def self.return_rates(parameters, hotels)
    hotels.each_value do |hotel|
      hotel = hotel.to_hash
      p hotel
      if parameters[0].downcase == "regular" 
        parameters[1..-1].each do |day|
          puts weekend?(day) ? cheapest('regular_weekend') : cheapest('regular_weekday')
        end
      elsif parameters[0].downcase == "rewards"
        parameters[1..-1].each do |day|
          puts weekend?(day) ? cheapest('rewards_weekend') : cheapest('rewards_weekday') 
        end
      else
        p "invalid input"
      end
    end
  end

  def self.weekend?(day)
    day = day.split(/(\D{3,})/).reverse
    day = Time.utc(*day)
    return day.saturday? || day.sunday?
  end

  def cheapest(day_rate)

    rates = []
    hotels = hotels.to_hash
    hotels.each_value do |hotel|
    hotel = hotel.to_hash
    rates << hotel[:rating]
    rates = rates.sort
      if rates[0] == rates[1]
        best_rating(hotels)
      end
    rates.first
    end
  end

  def self.best_rating(hotels)
    ratings = []
    hotels.each_value do |hotel|
      ratings << hotel[:rating]
      ratings.sort.last
    end
  end

end

module Booking
  extend Reader

  def self.run
    
    hotels = Reader.load_hotels_csv("hotels.csv").to_hash
    p hotels

    puts "Enter a customer type (Regular or Rewards) and desired dates (DayMonthYear format please):"
    parameters = Reader.inputs
    Hotel.return_rates(parameters, hotels)
    puts "Check other rates? Enter 'y' if so."
    affirm = gets.chomp
      while affirm.downcase == 'y'
        puts "Enter details:\n"
        Hotel.return_rates(Reader.inputs, hotels)
        puts "Check other rates? Enter 'y' if so."
        affirm = gets.chomp
      end
  end

    
end


Booking.run








