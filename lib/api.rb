class API

  def self.fetch_countries
    url = "https://restcountries.eu/rest/v2/lang/es" #save url of API endpoint with data
    uri = URI(url) #convert URL; URI command comes from net/http gem
    response = Net::HTTP.get(uri) #gets response of info from API
    array_of_countries = JSON.parse(response) #parse response to display as JSON using JSON gem

    array_of_countries.each do |country_hash| #iterate through each Country's hash in the array
      country = Country.new #create a new Country instance
      country.name = country_hash["name"] #name of Country set to value of Country hash's name key
      country.capital = country_hash["capital"] #capital of Country set to value of Country hash's capital key
      country.region = country_hash["region"] # region of Country set to value of Country hash's region key
      country.subregion = country_hash["subregion"] #subregion of Country set to value of Country hash's subregion key
      country.population = country_hash["population"] #population of Country set to value of Country hash's population key
      country.demonym = country_hash["demonym"] #demonym of Country set to value of Country hash's demonym key
      country.borders = country_hash["borders"] #borders of Country set to value of Country hash's borders key
      country_hash["currencies"].each do |type| #iterate through currencies array
          country.currency_name = type["name"] #currency_name of Country set to value of Country hash's currencies hash's name key
          country.currency_symbol = type["symbol"]#currency_symbol of Country set to value of Country hash's currencies hash's symbol key
      end
      country.native_name = country_hash["nativeName"] #native name of Country set to value of Country hash's native name key
    end
  end

end
