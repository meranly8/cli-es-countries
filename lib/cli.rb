class CLI
  attr_accessor :counter

  def start
    puts "¡Hola! ¿Cómo estás?"
    API.fetch_countries #grabs data from API and creates instances

    sleep(1)
    @counter = 0 #initialize counter for message logic
    self.open_menu #begin program logic
  end

  def open_menu
    if self.counter == 0 #If this is the first run of the progam
      puts "\n"
      puts "Would you like to learn more about Spanish speaking countries?" #prompt the user
      sleep(1)
      puts "Enter 'y' to view the country directory or any other key to exit" #instructions for input
      self.counter += 1 #increase counter
    else #If this is an additional run of the program
      sleep(3)
      puts "\n"
      puts "Would you like to learn more about another?" #prompt the user
      sleep(1)
      puts "Enter 'y' to view the country directory or any other key to exit" #instructions for input
    end

    user_input = gets.strip.downcase #waits for & takes user input, remove whitespace & standardize input to be lowercase

    if user_input == "y" #If user enters y
      puts "¡Muy bien! Here's a directory of the countries that speak Español."
      puts "\n"

      sleep(3)
      display_list_of_countries #call the method to display the list of Countries to choose from
      ask_for_country_selection #call method to ask user which Country to see

      open_menu #call the method to run it again from the top
    else #if user declines with other key
      puts "¡OK, adios!" #say goodbye to user and exit
    end
  end

  def display_list_of_countries
    puts "Country Directory".upcase #title of directory
    Country.all.each.with_index(1) do |country, index| #iterate through array of all Country instances and their index starting at 1
      puts "#{index}. #{country.name}" #to display each list number and Country name
    end
  end

  def ask_for_country_selection
    puts "\n"
    puts "Please enter the number of the country to learn more about it." #prompt user
    puts "Select a number 1-#{Country.all.length}." #instructions for input

    country_index = gets.strip.to_i-1 #waits for & takes user input, remove whitespace, convert to integer & subtract 1 to align with Country instances array index
    #error handling & messages
    until country_index.between?(0, Country.all.length-1) #until the input of the country_index is between 0 & Country instances array length -1 because array index starts at 0
      puts "¡No bueno! Invalid selection. Try another, por favor." #error message to prompt user of other input
      sleep(1)
      country_index = gets.strip.to_i-1 #ask for user input again to select country's index
    end

    country_selection = Country.all[country_index] #save selection as index of country in Country array

    display_selected_countrys_details(country_selection) #use selection to display that country's details
  end

  def display_selected_countrys_details(country) #accept argument of country to display based on index chosen
    puts "¡Excelente!"
    sleep(1)
    puts "\n" #display the details of the country
    puts "          #{country.name.upcase}"
    puts "   Native Name: #{country.native_name}"
    puts "   Capital:     #{country.capital}"
    puts "   Region:      #{country.region}"
    puts "                  #{country.subregion}"
    puts "\n"
    puts "   Demonym:     #{country.demonym}"
    puts "   Population:  #{country.population}"
    if country.borders.length == 0 #check to see if country is an island or not
      puts "   Borders:     #{country.name} is an island"
    else
      puts "   Borders:     #{country.borders.join(", ")}" #join borders array to display as string with elements separated by commas
    end
    puts "   Currency:    (#{country.currency_symbol}) #{country.currency_name}"
  end

end
