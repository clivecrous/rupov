require 'rupov'
require './include/genericscene'

puts Scene.new() { |scene|
    scene << RuPov::CSG::Difference.new() { |diff|
        diff << RuPov::Objects::FiniteSolidPrimitives::Sphere.new(
                RuPov::DataTypes::Vector::XYZ.new( -0.15, 0.5, -0.15), 0.45 ) { |sphere|
            sphere << RuPov::Textures::Pigments::SolidColour.new( RuPov::Methods::Colour.new( "Yellow" ) )
        }
        diff << RuPov::Objects::FiniteSolidPrimitives::Sphere.new(
                RuPov::DataTypes::Vector::XYZ.new(  0.15, 0.7,  0.15), 0.45 ) { |sphere|
            sphere << RuPov::Textures::Pigments::SolidColour.new( RuPov::Methods::Colour.new( "Red" ) )
        }
    }
}
