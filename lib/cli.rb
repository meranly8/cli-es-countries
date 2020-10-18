class CLI
  def start
    puts "Hello"
    API.fetch_countries

    sleep(1)
    self.view
  end

  def view
    puts "Would you like to learn more about Spanish speaking countries?"
    puts "Enter 'y' to view directory or any other key to exit"

    user_input = gets.strip.downcase

    if user_input == "y"
      puts "¡Muy bien!"

      sleep(1)
      display_list_of_countries

    end
  end

  def display_list_of_countries
    Country.all.each.with_index(1) do |country, index|
      puts "#{index}. #{country.name}"
    end
  end

end
