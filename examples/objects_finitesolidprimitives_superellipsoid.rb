require 'rupov'
require "./#{File.dirname(__FILE__)}/include/genericscene"

puts Scene.new() { |scene|
    scene << RuPov::Objects::FiniteSolidPrimitives::SuperEllipsoid.new(
            RuPov::DataTypes::Vector::XY.new( 0.5, 0.75) ) { |ellipsoid|
        ellipsoid << RuPov::Textures::Pigments::SolidColour.new( RuPov::Methods::Colour.new( "Yellow" ) )
        ellipsoid << RuPov::Methods::Scale.new( 0.5 )
        ellipsoid << RuPov::Methods::Translate.new( RuPov::DataTypes::Vector::XYZ.new(0,0.5,0) )
    }
}
