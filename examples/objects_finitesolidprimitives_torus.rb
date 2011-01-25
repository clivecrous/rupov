require 'rupov'
require './include/genericscene'

puts Scene.new() { |scene|
    scene << RuPov::Objects::FiniteSolidPrimitives::Torus.new( 0.65, 0.2 ) { |torus|
        torus << RuPov::Textures::Pigments::SolidColour.new( RuPov::Methods::Colour.new( "Yellow" ) )
        torus << RuPov::Methods::Translate.new( RuPov::DataTypes::Vector::XYZ.new( 0, 0.5, 0 ))
    }
}
