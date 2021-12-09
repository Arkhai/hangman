class ConsoleInterface
  # В константе FIGURES будут лежать все текстовые файлы из папки figures.
  FIGURES = Dir["#{__dir__}/../data/figures/*.txt"].
    sort.
    map { |file| File.read(file) }

  # На вход конструктор класса ConsoleInterface принимает экземпляр класса Game.
  def initialize(game)
    @game = game
  end

  # Выводит в консоль текущее состояние игры, используя данные из экземпляра
  # класса Game (количество ошибок, сколько осталось попыток и т.д.)
  def state
    puts "Слово: #{word_to_show}".colorize(:blue)
    puts "#{figure}".colorize(:yellow)
    puts "Ошибки (#{@game.errors_made}): #{errors_to_show}".colorize(:cyan)
    puts "У вас осталось ошибок: #{@game.errors_allowed}".colorize(:magenta)

    if @game.won?
      puts 'Поздравляем, вы выиграли!'.colorize(:green)
    elsif @game.lost?
      puts "Вы проиграли, загаданное слово: #{@game.word}".colorize(:red)
    end
  end
  

  # Возвращает фигуру из массива FIGURES, которая соответствует количеству
  # ошибок, сделанных пользователем на данный момент
  def figure
    FIGURES[@game.errors_made]
  end


  # Метод, который готовит слово для вывода "на игровом табло".

  # Метод трансформирует массив (записывает вместо nil два подчеркивания),
  # и склеивает в строку, разделяя элементы пробелами.
  def word_to_show
    result =
      @game.guessed_letters.map do |letter|
        if letter == nil
          '__'
        else
          letter
        end
      end

    result.join(' ')
  end

  # Получает массив ошибочных букв и склеивает их в строку вида "Х, У"
  def errors_to_show
    @game.errors.join(', ')
  end

  # Получает букву из пользовательского ввода, приводит её к верхнему регистру
  # и возвращает её
  def get_input
    print 'Введите следующую букву: '
    gets[0].upcase
  end
end
