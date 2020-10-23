class CLI
  attr_accessor :counter

  def start
    puts "¡Hola! ¿Cómo estás?"
    API.fetch_countries

    sleep(1)
    @counter = 0
    self.open_menu
  end

  def open_menu
    if self.counter == 0
      puts "\n"
      puts "Would you like to learn about Spanish speaking countries? (l/q/e)"
      puts "l = learn, q = quiz, e = exit"
      self.counter += 1
    else
      sleep(3)
      puts "\n"
      puts "Would you like to learn more about another or test your knowledge of the country capitals?"
      puts "l = learn, q = quiz, e = exit"
    end

    user_input = gets.strip.downcase

    while user_input.length > 1
        puts "¡Ay! Only 1 character, por favor."
        user_input = gets.strip.downcase
    end


    if user_input == "l"
      puts "¡Muy bien! Here's a directory of the countries that speak Español."
      puts "\n"

      sleep(3)
      display_list_of_countries

      ask_for_country_selection

      open_menu

    elsif user_input == "q"
      puts "¡Bien, vamonos!"
      puts "\n"

      capital_quiz
    else
      puts "¡OK, adios!"
      sleep(1)
    end
  end

  def display_list_of_countries
    puts "           Country Directory".upcase
    Country.all.each_with_index do |country, index|
      puts "   #{index+1}. #{country.name}"
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

    country_selection = Country.all[country_index]

    display_selected_countrys_details(country_selection)
  end

  def display_selected_countrys_details(country)
    puts "¡Excelente!"
    sleep(1)
    puts "\n"
    puts "          #{country.name.upcase}"
    puts "   Native Name: #{country.native_name}"
    puts "   Capital:     #{country.capital}"
    puts "   Region:      #{country.region}"
    puts "                  #{country.subregion}"
    puts "\n"
    puts "   Demonym:     #{country.demonym}"
    puts "   Population:  #{country.population}"
    if country.borders.length == 0
      puts "   Borders:     #{country.name} is an island"
    else
      puts "   Borders:     #{country.borders.join(", ")}"
    end
    puts "   Currency:    (#{country.currency_symbol}) #{country.currency_name}"
  end

  def capital_quiz
    quiz = Country.all.shuffle
    questions = quiz[0..2]

    grab_quiz_questions(questions)
  end

  def grab_quiz_questions(quiz_questions)
    quiz_content = []

    quiz_questions.each do |country|
      content = [country.name, country.capital]
      quiz_content << content
    end

    display_quiz_questions(quiz_content)
  end

  def display_quiz_questions(content)
    score = 0
    sleep(1)
    puts "Welcome to the Capital Quiz. ¡Buena suerte!"
    sleep(1)

    puts "What is the capital of #{content[0][0]}?"
    q1_input = gets.strip.downcase
    if q1_input == content[0][1].downcase
      puts "¡Correcto!"
      score += 1
    else
      puts "¡Ay lo siento! #{content[0][1].capitalize} is the capital of #{content[0][0].capitalize}"
    end

    puts "\n"
    puts "What is the capital of #{content[1][0]}?"
    q2_input = gets.strip.downcase
    if q2_input == content[1][1].downcase
      puts "¡Fabuloso!"
      score += 1
    else
      puts "¡Incorrecto! #{content[1][1].capitalize} is the capital of #{content[1][0].capitalize}"
    end

    puts "\n"
    puts "What is the capital of #{content[2][0]}?"
    q3_input = gets.strip.downcase
    if q3_input == content[2][1].downcase
      puts "¡Maravilloso!"
      score += 1
    else
      puts "¡Ay triste! #{content[2][1].capitalize} is the capital of #{content[2][0].capitalize}"
    end
    puts "\n"
    puts "\n"

    sleep(1)
    if score == 0 || score == 1
      puts "You scored #{score}/#{content.size}.¡No bueno! Keep studying."
      puts "\n"
    elsif score == 2
      puts "You scored #{score}/#{content.size}. Que bueno, amigo. "
      puts "\n"
    else
      puts "You scored #{score}/#{content.size}. ¡Magnífica! Very smart! "
    end

    sleep(1)
    open_menu
    # score_system(score, quiz_content)
  end

end
