require '../rupov/povray.rb'
require 'include/genericscene.rb'

puts Scene.new() { |scene|
    scene << Povray::Objects::FiniteSolidPrimitives::Cylinder.new(
            Povray::DataTypes::Vector::XYZ.new( 0,0,0),
            Povray::DataTypes::Vector::XYZ.new(0,1,0),
            0.5 ) { |cylinder|
        cylinder << Povray::Textures::Pigments::SolidColour.new( Povray::Methods::Colour.new( "Yellow" ) )
    }
}
