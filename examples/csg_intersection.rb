require '../rupov/povray.rb'
require 'include/genericscene.rb'

puts Scene.new() { |scene|
    scene << Povray::CSG::Intersection.new() { |intersect|
        intersect << Povray::Objects::FiniteSolidPrimitives::Sphere.new(
                Povray::DataTypes::Vector::XYZ.new( -0.15, 0.5, -0.15), 0.45 ) { |sphere|
            sphere << Povray::Textures::Pigments::SolidColour.new( Povray::Methods::Colour.new( "Yellow" ) )
        }
        intersect << Povray::Objects::FiniteSolidPrimitives::Sphere.new(
                Povray::DataTypes::Vector::XYZ.new(  0.15, 0.7,  0.15), 0.45 ) { |sphere|
            sphere << Povray::Textures::Pigments::SolidColour.new( Povray::Methods::Colour.new( "Red" ) )
        }
    }
}
