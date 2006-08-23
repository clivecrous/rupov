require '../rupov/povray.rb'
require 'include/genericscene.rb'

scene = Scene.new()

prism =
    Povray::Objects::FiniteSolidPrimitives::Prism.new(
        0,1,
        [
            Povray::DataTypes::Vector::XY.new( 3,5 ),
            Povray::DataTypes::Vector::XY.new(-3,5 ),
            Povray::DataTypes::Vector::XY.new(-5,0 ),
            Povray::DataTypes::Vector::XY.new(-3,-5 ),
            Povray::DataTypes::Vector::XY.new( 3,-5 ),
            Povray::DataTypes::Vector::XY.new( 5,0 ),
            Povray::DataTypes::Vector::XY.new( 3,5 )
        ] )

prism << Povray::Textures::Pigments::SolidColour.new( Povray::Methods::Colour.new( "Yellow" ) )
prism << Povray::Methods::MultiValue.new( [0.2], 'scale' )

scene << prism

puts scene
