require 'rupov'
require "./#{File.dirname(__FILE__)}/include/genericscene"

puts Scene.new() { |scene|
    scene << RuPov::Objects::FinitePatchPrimitives::Disc.new(
        RuPov::DataTypes::Vector::XYZ.new( 0,0.5,0),
        RuPov::DataTypes::Vector::XYZ.new(0,1,0),
        0.7,
        0.2) { |disc|
            disc << RuPov::Textures::Pigments::SolidColour.new( RuPov::Methods::Colour.new( "Yellow" ) )
        }
    }
