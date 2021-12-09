class Game
  # Количество допустимых ошибок
  ERRORS_ALLOWED = 7

  # Конструктор класса Game на вход получает строку с загаданным словом.
  #
  # В конструкторе инициализируем две переменные экземпляра: массив букв
  # загаданного слова и пустой массив для дальнейшего сбора в него вводимых
  # букв.
  def initialize(word)
    @letters = word.chars
    @user_letters = []
  end

  def normilize_letter(letter)
    case letter
    when 'Ё'
      'Е'
    when 'Й'
      'И'
    else
      letter
    end
  end

  def normilize_word
    @letters.map { |letter| normilize_letter(letter) }
  end

  # Возвращает массив букв, введенных пользователем, но отсутствующих в
  # загаданном слове (ошибочные буквы)
  def errors
    @user_letters - normilize_word
  end

  # Возвращает количество ошибок, сделанных пользователем
  def errors_made
    errors.length
  end
  
  # Отнимает от допустимого количества ошибок число сделанных ошибок и
  # возвращает оставшееся число допустимых ошибок
  def errors_allowed
    ERRORS_ALLOWED - errors_made
  end
  
  # Возвращает массив с уже отгаданными буквами, вместо неотгаданных букв в
  # массиве на соответствующем месте находится nil.
  def guessed_letters
    @letters.map do |letter|
      if @user_letters.include?(normilize_letter(letter))
        letter
      end
    end
  end
 
  # Возвращает true, если у пользователя не осталось ошибок, т.е. игра проиграна
  def lost?
    errors_allowed == 0
  end
  
  # Возвращает true, если игра закончена (проиграна или выиграна)
  def over?
    lost? || won?
  end

  # Если игра не закончена и передаваемая буква отсутствует в массиве
  # введённых букв, то закидывает передаваемую букву в массив "попыток".
  def play!(letter)
    if !over? and !@user_letters.include?(normilize_letter(letter))
      @user_letters << normilize_letter(letter) 
    end
  end
 
  # Возвращает true, если не осталось неотгаданных букв (пользователь выиграл)
  def won?
    (normilize_word - @user_letters).empty?
  end

  # Возвращает загаданное слово, склеивая его из загаданных букв
  def word
    @letters.join
  end
end
