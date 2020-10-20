class API

  def self.fetch_countries
    url = "https://restcountries.eu/rest/v2/lang/es"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    array_of_countries = JSON.parse(response)

    array_of_countries.each do |country_hash|
      country = Country.new
      country.name = country_hash["name"]
      country.capital = country_hash["capital"]
      country.region = country_hash["region"]
      country.subregion = country_hash["subregion"]
      country.population = country_hash["population"]
      country.borders = country_hash["borders"]
      country.currencies = country_hash["currencies"]
      country_hash["currencies"].each do |type|
          country.currency_name = type["name"]
          country.currency_symbol = type["symbol"]
      end
    end
  end

end
