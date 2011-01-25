require 'rupov'
require './include/genericscene'

puts Scene.new() { |scene|
    scene << RuPov::Objects::FiniteSolidPrimitives::Box.new(
            RuPov::DataTypes::Vector::XYZ.new( -0.5,0,-0.5 ),
            RuPov::DataTypes::Vector::XYZ.new(  0.5,1, 0.5 ) ) { |box|
        box << RuPov::Textures::Pigments::SolidColour.new( RuPov::Methods::Colour.new( "Yellow" ) )
    }
}
