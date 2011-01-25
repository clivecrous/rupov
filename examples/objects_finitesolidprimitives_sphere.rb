require 'rupov'
require "./#{File.dirname(__FILE__)}/include/genericscene"

puts Scene.new() { |scene|
    scene << RuPov::Objects::FiniteSolidPrimitives::Sphere.new(
            RuPov::DataTypes::Vector::XYZ.new( 0, 0.5, 0),
            0.45 ) { |sphere|
        sphere << RuPov::Textures::Pigments::SolidColour.new( RuPov::Methods::Colour.new( "Yellow" ) )
    }
}
