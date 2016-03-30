require_relative '../lib/game.rb'

describe Game do 

  describe '#setup' do   
    it 'asks codesetter to set code when human breaker is selected' do
      stub_input = double
      stub_string = "b"
      allow(stub_input).to receive(:gets).and_return("#{stub_string}\n")
      g = Game.new({input: stub_input})

      expect(g.codesetter).to receive(:code)
      puts "first test"
      g.setup 
    end

    it 'asks for input when human setter is selected' do
      stub_input = double
      stub_string = "s"
      allow(stub_input).to receive(:gets).and_return("#{stub_string}\n", "r\n", "r\n", "r\n", "r\n")
      g = Game.new({input: stub_input})

      expect(g).to receive(:get_code)
      g.setup 
    end
  end

  describe '#get_colour' do
    it 'return a colour if input is valid' do
      stub_input = double
      stub_string = Game::COLOURS.values.sample
      allow(stub_input).to receive(:gets).and_return("#{stub_string}\n")
      g = Game.new({input: stub_input})

      expect(Game::COLOURS.keys).to include g.get_colour
    end

    # NB THIS TEST ASSUMES '@' IS NOT A VALID INPUT
    it 'will not accept incorrect symbols' do
      stub_input = double
      stub_string = Game::COLOURS.values.sample
      allow(stub_input).to receive(:gets).and_return("@\n", "@\n", "#{stub_string}\n")
      g = Game.new({input: stub_input})
      
      expect(Game::COLOURS.keys).to include g.get_colour
      end
  end

  describe '#get_guess' do
    it 'returns an array of four colours' do
      stub_input = double
      stub_string = Game::COLOURS.values.sample
      stub_colour = Game::COLOURS.keys.sample
      allow(@codesetter).to receive(:code).and_return([stub_colour, stub_colour, stub_colour, stub_colour])
      allow(stub_input).to receive(:gets).and_return("#{stub_string}\n")
      g = Game.new({input: stub_input})
      expect(g.get_guess.size).to eq 4
    end
  end



end