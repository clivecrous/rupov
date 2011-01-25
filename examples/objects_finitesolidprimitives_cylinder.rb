require 'rupov'
require "./#{File.dirname(__FILE__)}/include/genericscene"

puts Scene.new() { |scene|
    scene << RuPov::Objects::FiniteSolidPrimitives::Cylinder.new(
            RuPov::DataTypes::Vector::XYZ.new( 0,0,0),
            RuPov::DataTypes::Vector::XYZ.new(0,1,0),
            0.5 ) { |cylinder|
        cylinder << RuPov::Textures::Pigments::SolidColour.new( RuPov::Methods::Colour.new( "Yellow" ) )
    }
}
