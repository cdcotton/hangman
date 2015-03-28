def init
  dict = File.read('5desk.txt')
  dict = dict.split

  dict = dict.select do |word|
    word.length >= 5 && word.length <= 12
  end

  dict[rand(0...dict.length)].downcase
end

def play
  word = init
  guesses_left = 10
  incorrect_letters = []
  word_positions = Array.new(word.length).fill('_')
  game_over = false

  until game_over do
    puts "Guesses left: #{guesses_left}"
    puts "Incorrect letters: #{incorrect_letters.join(', ')}"
    puts "Word: #{word_positions.join(' ')}"
    print 'Your guess: '
    guess = gets.chomp.downcase

    if guess.length > 1
      puts 'Not a valid guess!'
    elsif incorrect_letters.any? { |letter| letter == guess }
      puts 'You already guessed that letter!'
    else
      if word.split('').any? { |letter| letter == guess }
        puts "Correct!"

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
    puts "You won! You correctly guessed \'#{word}!\' with #{guesses_left} \
          guesses left!"
  end
  puts ''
end

play
