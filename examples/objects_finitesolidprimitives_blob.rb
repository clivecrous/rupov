require 'rupov'
require "./#{File.dirname(__FILE__)}/include/genericscene"

puts Scene.new() { |scene|
    scene << RuPov::Objects::FiniteSolidPrimitives::Blob.new( 0.5 ) { |blob|
        blob << RuPov::Objects::FiniteSolidPrimitives::Sphere.new(
                RuPov::DataTypes::Vector::XYZ.new( -0.15, 0.5, -0.15), 0.45 ) { |sphere|
            sphere << 1 # It's blob strength
            sphere << RuPov::Textures::Pigments::SolidColour.new( RuPov::Methods::Colour.new( "Yellow" ) )
        }
        blob << RuPov::Objects::FiniteSolidPrimitives::Sphere.new(
                RuPov::DataTypes::Vector::XYZ.new(  0.15, 0.7,  0.15), 0.45 ) { |sphere|
            sphere << 1 # It's blob strength
            sphere << RuPov::Textures::Pigments::SolidColour.new( RuPov::Methods::Colour.new( "Red" ) )
        }
    }
}
