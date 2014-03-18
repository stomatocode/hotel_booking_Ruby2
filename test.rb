
# def get_input
#   parameters = ""
#   while parameters != ""
#     parameters = gets.chomp
#     parameters = parameters.gsub(/\W\s+|(\([a-z]*\)|,)/, ' ')
#     options = parameters.split(/\s+|(\([a-z]*\)|,)/)  
#   end
# end

# def weekend?(day)
#   day = day.split(/(\D{3,})/).reverse
#   day = Time.utc(*day)
#   return day.saturday? || day.sunday?
# end

# def return_rates(options, hotels)
  
#   if options[0].downcase == "regular" 
#       options[1..-1].each do |day|
#         puts weekend?(day) ? "cheapest Regular weekend rate" : "cheapest Regular weekday rate" #write method for 'cheapest'
#       end
#   elsif options[0].downcase == "rewards"
#       options[1..-1].each do |day|
#         puts weekend?(day) ? "cheapest Rewards weekend rate" : "cheapest Rewards weekday rate" #write method for 'cheapest'
#       end
#   else
#     p "invalid input"
#   end

# end

# def cheapest(options)

#   # hotel_list = 

#   rates = []
#   day = options[:day]
#   type = options[:type]
#   hotels.each_value do |hotel|
#     rates << hotel
#   end
# end

# def best_rating(*hotels)
#   ratings = []
#   hotels.each do |hotel|
#     ratings << hotel.rating.to_i
#     ratings.sort.last
#   end
# end

# return_rates(get_input)


#   def self.load_hotels_csv(filename)
#     regular = {}
#     rewards = {}
#     hotels = {}
#     CSV.foreach(filename, :headers => true, :header_converters => :symbol) do |row|
#       hotels[row[:name].downcase.to_sym] = Hotel.new(row)
#     end
#     hotels.to_hash
#   end


# # Regular: 16Mar2009(mon), 17Mar2009(tues), 22Mar2009(wed)

require 'csv'
require 'pry'
require 'pry-debugger'


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

  def weekend?(day)
    day = day.split(/(\D{3,})/).reverse
    day = Time.utc(*day)
    return day.saturday? || day.sunday?
  end

  def self.best_rating(hotels)
    ratings = []
    hotels.each_value do |hotel|
      ratings << hotel[:rating]
      ratings.sort.last
    end
  end

  def to_hash
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete("@")] = instance_variable_get(var) }
    hash
  end

end

# stuff:

def load_hotels_csv(filename)
  hotels = {}
  CSV.foreach(filename, :headers => true, :header_converters => :symbol) do |row|
    hotels[row[:name].downcase.to_sym] = Hotel.new(row)
  end
  hotels
end

def rewards(hotels)
  p hotels
  rewards = {}
  hotels.each_value do |hotel_object|
    rewards = hotel_object.to_hash
    # hotel_object.each_pair do |key, value|
    #   rewards[:rewards_weekend] = value
    #   rewards[:rewards_week] = value
    # end  
  end  
  p rewards
end 


def return_rates(category_hash)

end




# p load_hotels_csv("hotels.csv")
rewards(load_hotels_csv("hotels.csv"))
























































