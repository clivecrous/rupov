require 'include/genericscene.rb'

scene = Scene.new()

box =
    Povray::Objects::FiniteSolidPrimitives::Box.new(
        Povray::DataTypes::Vector::ThreeD.new( -0.5,0,-0.5 ),
        Povray::DataTypes::Vector::ThreeD.new(  0.5,1, 0.5 ) )
box << Povray::Textures::Pigments::SolidColour.new( Povray::Methods::Colour.new( "Yellow" ) )
scene << box

puts scene
