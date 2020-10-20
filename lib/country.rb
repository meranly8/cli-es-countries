class Country
  attr_accessor :name, :native_name, :capital, :region, :subregion, :population, :demonym, :borders, :currencies, :currency_name, :currency_symbol

  @@all = []

  def initialize
    @@all << self
  end

  def self.all
    @@all
  end

end
