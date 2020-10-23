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
      puts "Would you like to learn about Spanish speaking countries?"
      puts "   l = learn, q = quiz, e = exit"
    elsif self.counter.odd?
      sleep(2)
      puts "\n"
      puts "Would you like to review more countries or test your knowledge of the country capitals?"
      puts "   r = review, t = test, e = exit"
    elsif self.counter.even?
      puts "\n"
      puts "Would you like to try the quiz again or study country data?"
      puts "   s = study, q = quiz, e = exit"
    end

    user_input = gets.strip.downcase

    while user_input.length > 1
        puts "¡Ay! Only 1 character, por favor."
        user_input = gets.strip.downcase
    end


    if user_input == "l" || user_input == "s" || user_input == "r"
      self.counter += 1
      puts "¡Muy bien! Here's a directory of the countries that speak Español."
      puts "\n"

      sleep(3)
      display_list_of_countries

      ask_for_country_selection

      open_menu

    elsif user_input == "q" || user_input == "t"
      self.counter += 2
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

    self.counter -= 1 if self.counter.even?

  end

  def capital_quiz
    quiz = Country.all.shuffle
    questions = quiz[0..2]

    gather_quiz_content(questions)
  end

  def gather_quiz_content(quiz_questions)
    quiz_content = []

    quiz_questions.each do |country|
      content = [country.name, country.capital]
      quiz_content << content
    end

    start_quiz(quiz_content)
  end

  def start_quiz(content)
    score = 0
    sleep(1)
    puts "Welcome to the Capital Quiz. ¡Buena suerte!"
    puts "Accents count so if needed, copy from below."
    puts "  Á á   Å å   É é   Í í   Ó ó   Ú ú   Ñ ñ "
    puts "\n"
    sleep(1)

    puts "What is the capital of #{content[0][0]}?"
    q1_input = gets.strip.downcase
    if q1_input == content[0][1].downcase
      puts "   ¡Sí, correcto! #{content[0][1].capitalize} is the capital of #{content[0][0]}.".colorize(:green)
      score += 1
    else
      puts "   ¡Ay lo siento! #{content[0][1].capitalize} is the capital of #{content[0][0]}.".colorize(:red)
    end

    puts "\n"
    puts "What is the capital of #{content[1][0]}?"
    q2_input = gets.strip.downcase
    if q2_input == content[1][1].downcase
      puts "   ¡Sí, fabuloso! #{content[1][1].capitalize} is the capital of #{content[1][0]}.".colorize(:green)
      score += 1
    else
      puts "   ¡Incorrecto! #{content[1][1].capitalize} is the capital of #{content[1][0]}.".colorize(:red)
    end

    puts "\n"
    puts "What is the capital of #{content[2][0]}?"
    q3_input = gets.strip.downcase
    if q3_input == content[2][1].downcase
      puts "   ¡Sí, maravilloso! #{content[2][1].capitalize} is the capital of #{content[2][0]}.".colorize(:green)
      score += 1
    else
      puts "   ¡Ay triste! #{content[2][1].capitalize} is the capital of #{content[2][0]}.".colorize(:red)
    end
    puts "\n"

    score_messages(score, content)
  end

  def score_messages(quiz_score, quiz_content)
    sleep(1)
    if quiz_score == 0 || quiz_score == 1
      puts "You scored #{quiz_score}/#{quiz_content.size}.¡No bueno! Keep studying."
      puts "\n"
    elsif quiz_score == 2
      puts "You scored #{quiz_score}/#{quiz_content.size}. Bueno, amigo. Try again."
      puts "\n"
    else
      puts "You scored #{quiz_score}/#{quiz_content.size}. ¡Magnífica! Very smart! "
    end

    self.counter -= 1 if self.counter.odd?

    open_menu
  end

end
