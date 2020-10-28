class CLI
  attr_accessor :counter

  def start
    puts "¡Hola! ¿Cómo estás?"
    API.fetch_countries

    sleep(1)
    @counter = 0
    self.main_menu
  end

  def main_menu
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

    input = gets.strip.downcase

    while input.length > 1
        puts "¡Ay! Only 1 character, por favor."
        input = gets.strip.downcase
    end


    if input == "l" || input == "s" || input == "r"
      self.counter += 1
      puts "¡Muy bien! Below is a directory of the countries speaking Español."
      puts "\n"

      sleep(3)
      display_list_of_countries

      ask_for_country_selection

      main_menu

    elsif input == "q" || input == "t"
      self.counter += 2
      puts "¡Bien, vamos al examen!"
      puts "\n"

      build_capitals_quiz
    else
      puts "¡OK, adios!"
      sleep(1)
    end
  end

  def display_list_of_countries
    puts "           Country Directory".upcase.colorize(:blue)
    Country.all.each_with_index do |country, index|
      puts "   #{index+1}. #{country.name}"
    end
  end

  def ask_for_country_selection
    puts "\n"
    puts "Enter the number of the country to learn more about it."
    puts "Select a number 1-#{Country.all.size}."

    country_index = gets.strip.to_i-1

    until country_index.between?(0, Country.all.size-1)
      puts "¡No bueno! Invalid selection. Try another, por favor."
      sleep(1)
      country_index = gets.strip.to_i-1
    end

    country_selection = Country.all[country_index]

    display_selected_country_details(country_selection)
  end

  def display_selected_country_details(country)
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
    if country.borders.size == 0
      puts "   Borders:     #{country.name} is an island"
    else
      puts "   Borders:     #{country.borders.join(", ")}"
    end
    puts "   Currency:    (#{country.currency_symbol}) #{country.currency_name}"

    self.counter -= 1 if self.counter.even?

  end

  def build_capitals_quiz
    shuffle_countries = Country.all.shuffle
    countries_for_quiz = shuffle_countries[0..2]

    start_quiz(countries_for_quiz)
  end

  def start_quiz(quiz_questions)
    score = 0

    sleep(1)
    puts "Welcome to the Capitals Quiz. ¡Buena suerte!".colorize(:blue)
    puts "  Accents count. If needed, copy from below.".colorize(:blue)
    puts "   Á á   Å å   É é   Í í   Ó ó   Ú ú   Ñ ñ "
    puts "\n"
    sleep(1)

    quiz_questions.each do |country|
      correct_messages = ["¡Correcto!", "¡Fabuloso!", "¡Maravilloso!", "¡Estupendo!", "¡Inteligente!"].shuffle
      incorrect_messages = ["¡Incorrecto!", "¡Ay triste!", "¡Ay no!", "No bueno.", "¡Ay mio!"].shuffle
      answer_string = "#{country.capital} is the capital of #{country.name}."

      puts "What is the capital of #{country.name}?"
      input = gets.strip.downcase

      if input == country.capital.downcase
        puts "   #{correct_messages.first} #{answer_string}".colorize(:green)
        puts "\n"
        score += 1
      else
        puts "   #{incorrect_messages.first} #{answer_string}".colorize(:red)
        puts "\n"
      end
    end

    score_messages(score, quiz_questions)
  end

  def score_messages(quiz_score, quiz_questions)
    sleep(1)
    score_out_of = "You scored #{quiz_score}/#{quiz_questions.size}."

    if quiz_score == 0 || quiz_score == 1
      puts "#{score_out_of} ¡No bueno! Keep studying."
      puts "\n"
    elsif quiz_score == 2
      puts "#{score_out_of} Bueno, amigo. Try again."
      puts "\n"
    else
      puts "#{score_out_of} ¡Magnífica, 100%! ¡Muy inteligente! "
    end

    self.counter -= 1 if self.counter.odd?

    main_menu
  end

end
