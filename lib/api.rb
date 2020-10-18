class API

  def self.fetch_countries
    url = "https://restcountries.eu/rest/v2/lang/es"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    array_of_countries = JSON.parse(response)

    make_countries(array_of_countries)
  end

  def make_countries(countries_array)
    countries_array.each do |country_hash|
      country = Country.new
      country.name = country_hash["name"]
      country.capital = country_hash["capital"]
      country.region = country_hash["region"]
      country.subregion = country_hash["subregion"]
      country.population = country_hash["population"]
      country.borders = country_hash["borders"]
      country.currencies = country_hash["currencies"]
    end
  end

end
