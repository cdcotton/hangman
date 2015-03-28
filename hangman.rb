def init
  dict = File.read('5desk.txt')
  dict = dict.split

  dict = dict.select do |word|
    word.length >= 5 && word.length <= 12
  end

  dict[rand(0...dict.length)].downcase
end

def save(content)
  print 'Choose your save file name (no extension): '
  fname = gets.chomp << '.txt'

  File.write(fname, content)
end

def play
  word = init
  guesses_left = 10
  incorrect_letters = []
  word_positions = Array.new(word.length).fill('_')
  game_over = false

  print 'Would you like to load a saved game? (Y/N): '
  load = gets.chomp.downcase
  if load.start_with?('y')
    print 'Enter the save file name (no extension): '
    fname = gets.chomp << '.txt'

    file = File.open(fname, 'r')
    contents = file.read.split('|')

    word = contents[0]
    guesses_left = contents[1].to_i
    incorrect_letters = contents[2].split('')
    word_positions = contents[3].split('')
  end

  until game_over
    puts "Guesses left: #{guesses_left}"
    puts "Incorrect letters: #{incorrect_letters.join(', ')}"
    puts "Word: #{word_positions.join(' ')}"
    puts ''
    puts "Enter \'save\' to save your current game."
    print '>  '
    guess = gets.chomp.downcase

    if guess == 'save'
      content = [word, guesses_left, incorrect_letters.join,\
                 word_positions.join].join('|')
      save(content)
    elsif guess.length > 1
      puts 'Not a valid guess!'
    elsif incorrect_letters.any? { |letter| letter == guess } \
          || word_positions.any? { |letter| letter == guess }
      puts 'You already guessed that letter!'
    else
      if word.split('').any? { |letter| letter == guess }
        puts 'Correct!'

        positions = []
        word.split('').each_with_index do |letter, i|
          positions << i if letter == guess
        end

        positions.each { |i| word_positions[i] = guess }
      else
        puts 'Try again!'
        guesses_left -= 1

        incorrect_letters << guess
      end
      game_over = word_positions.none? { |letter| letter == '_' } \
      || guesses_left == 0
    end
    puts ''
  end

  puts "Guesses left: #{guesses_left}"
  puts "Incorrect letters: #{incorrect_letters.join(', ')}"
  puts "Word: #{word_positions.join(' ')}"

  if guesses_left == 0
    puts "Out of guesses! The word was \'#{word}\'."
  else
    puts "You won! You correctly guessed \'#{word}!\' " \
          "with #{guesses_left} guesses left!"
  end
  puts ''
end

play
