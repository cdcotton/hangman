def init
  dict = File.read('5desk.txt')
  dict = dict.split

  dict = dict.select do |word|
    word.length >= 5 && word.length <= 12
  end

  dict[rand(0...dict.length)]
end

def play
  word = init

  puts word
end

play
