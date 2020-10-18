class Country
  attr_accessor :name, :capital, :region, :subregion, :population, :borders, :currencies

  @@all = []

  def initialize
    @@all << self
  end

  def self.all
    @@all
  end

end
