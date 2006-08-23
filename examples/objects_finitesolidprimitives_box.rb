require '../rupov/povray.rb'
require 'include/genericscene.rb'

puts Scene.new() { |scene|
    scene << Povray::Objects::FiniteSolidPrimitives::Box.new(
            Povray::DataTypes::Vector::XYZ.new( -0.5,0,-0.5 ),
            Povray::DataTypes::Vector::XYZ.new(  0.5,1, 0.5 ) ) { |box|
        box << Povray::Textures::Pigments::SolidColour.new( Povray::Methods::Colour.new( "Yellow" ) )
    }
}
