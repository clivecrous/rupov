require 'rupov'
require './include/genericscene'

puts Scene.new() { |scene|
    scene << RuPov::CSG::Merge.new() { |merge|
        merge << RuPov::Objects::FiniteSolidPrimitives::Sphere.new(
                RuPov::DataTypes::Vector::XYZ.new( -0.15, 0.5, -0.15), 0.45 ) { |sphere|
            sphere <<  RuPov::Textures::Pigments::SolidColour.new(
                    RuPov::Methods::Colour.new( "Yellow" ) )
        }
        merge << RuPov::Objects::FiniteSolidPrimitives::Sphere.new(
                RuPov::DataTypes::Vector::XYZ.new(  0.15, 0.7,  0.15), 0.45 ) { |sphere|
            sphere <<  RuPov::Textures::Pigments::SolidColour.new(
                    RuPov::Methods::ColourRGBT.new( RuPov::DataTypes::Vector::RGBT.new( 1,0,0,0.8 ) ) )
        }
    }
}
