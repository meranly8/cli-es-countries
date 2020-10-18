class CLI
  def start
    puts "Hello"
    API.fetch_countries
  end
end
