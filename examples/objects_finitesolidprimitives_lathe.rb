require 'rupov'
require "./#{File.dirname(__FILE__)}/include/genericscene"

puts Scene.new() { |scene|
    scene << RuPov::Objects::FiniteSolidPrimitives::Lathe.new(
            [
                RuPov::DataTypes::Vector::XY.new( 0,0 ),
                RuPov::DataTypes::Vector::XY.new( 1,1 ),
                RuPov::DataTypes::Vector::XY.new( 2,3 ),
                RuPov::DataTypes::Vector::XY.new( 2,4 ),
                RuPov::DataTypes::Vector::XY.new( 2,5 ),
                RuPov::DataTypes::Vector::XY.new( 0,4.75 )
            ] ) { |lathe|
        lathe << RuPov::Textures::Pigments::SolidColour.new( RuPov::Methods::Colour.new( "Yellow" ) )
        lathe << RuPov::Methods::MultiValue.new( [0.2], 'scale' )
    }
}
