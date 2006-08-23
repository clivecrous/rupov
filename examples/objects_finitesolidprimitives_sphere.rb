require '../rupov/povray.rb'
require 'include/genericscene.rb'

scene = Scene.new() { |scene|

    scene << Povray::Objects::FiniteSolidPrimitives::Sphere.new(
            Povray::DataTypes::Vector::XYZ.new( 0, 0.5, 0),
            0.45 ) { |sphere|
        sphere << Povray::Textures::Pigments::SolidColour.new( Povray::Methods::Colour.new( "Yellow" ) )
    }
}

puts scene
