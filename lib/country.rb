class Country
  attr_accessor :name, :capital, :region, :subregion, :population, :borders, :currencies, :currency_name, :currency_symbol

  @@all = []

  def initialize
    @@all << self
  end

  def self.all
    @@all
  end

end
