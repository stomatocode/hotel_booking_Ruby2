 
require_relative "../ruby_reservations.rb"

describe Reader do 

  let(:collection) { Collection.new('hotels.csv') }
  let(:hotels) {collection.hotels}

  context "gets data from csv file" do

    it "should create a nested hash" do
      expect(hotels.first).to eql([:lakewood, {:name=>"Lakewood", :rating=>"3", :regular_weekday=>"110", :regular_weekend=>"90", :rewards_weekday=>"80", :rewards_weekend=>"80"}])
    end

  end

  context "acessible with hash methods" do
    it "should get a member value" do
      expect(hotels.values.first[:name]).to eql("Lakewood")
    end
  end

end

describe Collection do

  let(:collection) { Collection.new('hotels.csv') }
  let(:hotels) {collection.hotels}
  let(:rewards_array) {['rewards', '22Mar2009', '17Mar2009']}
  let(:regular_array) {['regular', '17Mar2009', '22Mar2009']}
  let(:date) {"22Mar2009"}
  let(:day_rate) {:rewards_weekend}
  let(:lakewood) {:lakewood}
  let(:ridgewood) {:ridgewood}
  let(:rates) {collection.get_rates(:rewards_weekend)}
  let(:just_the_cheapest) {:regular_weekend}
  let(:tied_rate) {collection.best_rating(:ridgewood, :driftwood)}
  let(:blackout) {"25Dec2014"}

  context "initializes with" do
    it "Reader module method" do 
      expect(hotels).not_to be_empty
    end

    it "empty hash instance methods" do
      expect(collection.rates).to be_empty
    end
  end

  describe "#find_hotel" do
    it "should accept array of parameters" do
      expect{collection.find_hotel(rewards_array)}.not_to raise_error 
    end

    it "should call #weekend? for each date" do
      expect{collection.weekend?(date)}.not_to raise_error
    end

    it "should call #best_choice with the results of #weekend?" do
      expect{collection.best_choice(day_rate)}.not_to raise_error
    end

    it "should reject improper date formats" do
      expect(collection.find_hotel("Mar222009")).to eql("invalid input")
    end

  end

  describe "#weekend?" do
    it "should accept a date" do
      expect{collection.weekend?(regular_array[1])}.not_to raise_error 
    end

    it "should return true for a weekend date" do
      expect(collection.weekend?(date)).to eql(true)
    end
  end

  describe "#blackout?" do
    it "should return true if xmas" do
      expect(collection.blackout?(blackout)).to eql(true)
    end

  end

  describe "#get_rates" do 
    it "should return a hash of keys and rates" do
      expect(collection.get_rates(day_rate)).to be_a(Hash)
    end

    it "should change value of @rates" do
      expect(collection.get_rates(day_rate)).to eql(rates)
    end
  end

  describe "#best_rating" do
    it "should accept two symbols as arguments" do
      expect{collection.best_rating("lakewood")}.to raise_error
    end

    it "should return a name value" do
      expect(collection.best_rating(lakewood,ridgewood)).to be_a(String)
    end

    it "should return hotel with higher rating" do
      expect(collection.best_rating(lakewood,ridgewood)).to eql("Ridgewood")
    end
  end

  describe "#best_choice" do
    it "is the cheapest" do  
      expect(collection.best_choice(just_the_cheapest)).to eql("Bridgewood")
    end

    it "is the highest rated when there is a tie on price" do
      expect(collection.best_choice(:rewards_weekend)).to eql("Ridgewood")
    end

    # it "calls #blackout?"
  end

end







