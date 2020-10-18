class API

  def self.fetch_countries
    url = "https://restcountries.eu/rest/v2/lang/es"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    binding.pry
    array = JSON.parse(response)
  end
  
end
