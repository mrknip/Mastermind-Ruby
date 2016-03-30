require_relative 'codesetter'
require_relative 'codebreaker'

# Includes setup, game loop and methods to harvest player input
class Game
  COLOURS = {
    red: 'r',
    blue: 'b',
    green: 'g',
    yellow: 'y',
    purple: 'p',
    orange: 'o'
  }.freeze

  attr_reader :codesetter, :codebreaker

  def initialize(options = { codesetter: Codesetter.new,
                             codebreaker: Codebreaker.new,
                             input: $stdin })

    @codesetter = options[:codesetter]
    @codebreaker = options[:codebreaker]
    @input = options[:input]
  end

  def setup(n = 4)
    @player_role = get_role
    @code = (@player_role == :setter ? get_code(n) : @codesetter.code)

    @guesses = []
    @responses = []
    @turn = 1
  end

  def get_role
    puts 'Do you want to [b]reak or [s]et the code?'
    case @input.gets.chomp.downcase
    when 'b' then return :breaker
    when 's' then return :setter
    end
  end

  def get_code(n)
    puts 'Setting the code'
    n.times do
      get_colour
    end
  end

  def get_colour
    loop do
      puts "\nEnter: [R]ed, [B]lue, [G]reen, [Y]ellow, [P]urple or [O]range"
      input = @input.gets.chomp.downcase
      unless COLOURS.values.include? input
        p 'Please enter a valid guess'
        redo
      end
      return to_colour(input)
    end
  end

  def to_colour(string)
    COLOURS.key(string)
  end

  def get_guess
    guess = []
    @codesetter.code.size.times do
      guess << get_colour
    end
    guess
  end

  def check_against_code(guess)
    @codesetter.check_guess(guess)
  end

  def display
    puts "Turn #{@turn}"
    (0..(@turn - 1)).each do |i|
      print "Guess #{@guesses[i]}  ||  #{@responses[i]}\n"
    end
  end

  def end_game(result)
    case result
    when :win then puts 'Code breaker wins!'
    when :draw then puts 'Code setter wins!'
    end
    exit
  end

  def win?
    @responses[-1].all? { |r| r == :black } && @responses[-1].size == 4
  end

  def play
    setup
    while @turn <= 12
      @guesses << (@player_role == :breaker ? get_guess : @codebreaker.set_guess)
      system('cls')
      @responses << check_against_code(@guesses[-1])
      display
      end_game(:win) if win?
      @turn += 1
    end
    end_game(:draw)
  end
end
