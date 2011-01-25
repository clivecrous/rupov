require 'rupov'
require './include/genericscene'

puts Scene.new() { |scene|
    scene << RuPov::Objects::FiniteSolidPrimitives::Cone.new(
            RuPov::DataTypes::Vector::XYZ.new(0,0,0), 0.6,
            RuPov::DataTypes::Vector::XYZ.new(0,1,0), 0.3 ) { |cone|
        cone << RuPov::Textures::Pigments::SolidColour.new( RuPov::Methods::Colour.new( "Yellow" ) )
    }
}
