require '../rupov/povray.rb'
require 'include/genericscene.rb'

puts Scene.new() { |scene|
    scene << Povray::Objects::FiniteSolidPrimitives::Blob.new( 0.5 ) { |blob|
        blob << Povray::Objects::FiniteSolidPrimitives::Sphere.new(
                Povray::DataTypes::Vector::XYZ.new( -0.15, 0.5, -0.15), 0.45 ) { |sphere|
            sphere << 1 # It's blob strength
            sphere << Povray::Textures::Pigments::SolidColour.new( Povray::Methods::Colour.new( "Yellow" ) )
        }
        blob << Povray::Objects::FiniteSolidPrimitives::Sphere.new(
                Povray::DataTypes::Vector::XYZ.new(  0.15, 0.7,  0.15), 0.45 ) { |sphere|
            sphere << 1 # It's blob strength
            sphere << Povray::Textures::Pigments::SolidColour.new( Povray::Methods::Colour.new( "Red" ) )
        }
    }
}
