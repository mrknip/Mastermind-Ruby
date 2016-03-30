require_relative 'game' 
class Codebreaker

  def initialize
  end

  def set_guess
    guesses = []
    4.times do
      guesses << Game::COLOURS.keys.sample # GET THESE INJECTED BY GAME
    end
    p guesses
    guesses
  end

end
