class CLI
  def start
    puts "¡Hola!"
    API.fetch_countries

    sleep(1)
    self.open_menu
  end

  def open_menu
    counter = 0
    if counter == 0
      puts "\n"
      puts "Would you like to learn more about Spanish speaking countries?"
      sleep(1)
      puts "Enter 'y' to view the country directory or any other key to exit"
      counter += 1
    else
      puts "Would you like to view another?"
      sleep(1)
      puts "Enter 'y' to view the country directory or any other key to exit"
    end

    user_input = gets.strip.downcase

    if user_input == "y"
      puts "¡Muy bien! Here's a directory of the countries that speak Español."
      puts "\n"

      sleep(3)
      display_list_of_countries
      ask_for_country_selection

      open_menu
    else
      puts "¡OK, adios!"
    end
  end

  def display_list_of_countries
    puts "Country Directory".upcase
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
      puts "¡No bueno! Invalid selection. Try another, por favor."
      sleep(1)
      country_index = gets.strip.to_i-1
    end
    #save selection as index of country in Country array
    country_selection = Country.all[country_index]
    #use selection to display that country's details
    display_selected_countrys_details(country_selection)
  end

  def display_selected_countrys_details(country)
    puts "¡Excelente!"
    sleep(1)
    puts "\n"
    puts "         #{country.name.upcase}"
    puts "   Name:        #{country.name}"
    puts "   Capital:     #{country.capital}"
    puts "   Region:      #{country.region}"
    puts "                  #{country.subregion}"
    puts "\n"
    puts "   Population:  #{country.population}"
    if country.borders.length == 0
      puts "   Borders:     #{country.name} is an island"
    else
      puts "   Borders:     #{country.borders.join(", ")}"
    end
    puts "   Currency:    (#{country.currency_symbol}) #{country.currency_name}"
  end

end
