require 'rupov'

describe RuPov::Methods::Colour do
  it 'initializes with a colour value' do
    red,green,blue =
      RuPov::Methods::Colour.new( "red" ),
      RuPov::Methods::Colour.new( "green" ),
      RuPov::Methods::Colour.new( "blue" )

    red.to_s.should == 'colour red'
    green.to_s.should == 'colour green'
    blue.to_s.should == 'colour blue'
  end
end

