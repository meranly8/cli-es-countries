class CLI
  def start
    puts "¡Hola!"
    API.fetch_countries

    sleep(1)
    self.view
  end

  def view
    puts "Would you like to learn more about Spanish speaking countries?"
    puts "Enter 'y' to view the country directory or any other key to exit"

    user_input = gets.strip.downcase

    if user_input == "y"
      puts "¡Muy bien! Here's a directory of the countries that speak Español."
      puts "\n"

      sleep(2)
      display_list_of_countries
      ask_for_country_selection
      #ask for input of which country to view details of
    end
  end

  def display_list_of_countries
    Country.all.each.with_index(1) do |country, index|
      puts "#{index}. #{country.name}"
    end
  end

  def ask_for_country_selection
    puts "\n"
    puts "Please enter the number of the country to learn more about it."
    puts "Select a number 1-#{Country.all.length}."

    country_index = gets.strip.to_i-1

    until country_index.between?(0, Country.all.length-1)
      puts "¡No bueno! Please try another selection."
      puts "\n"
      sleep(1)
      country_index = gets.strip.to_i-1
    end
    #save selection as index of country in Country array
    country_selection = Country.all.[country_index]
    #use selection to display that country's details

    def display_selected_countrys_details(country)
      sleep(1)
      
    end
  end

end
