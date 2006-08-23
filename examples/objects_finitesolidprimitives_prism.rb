require '../rupov/povray.rb'
require 'include/genericscene.rb'

puts Scene.new() { |scene|
    scene << Povray::Objects::FiniteSolidPrimitives::Prism.new(
            0,1,
            [
                Povray::DataTypes::Vector::XY.new( 3,5 ),
                Povray::DataTypes::Vector::XY.new(-3,5 ),
                Povray::DataTypes::Vector::XY.new(-5,0 ),
                Povray::DataTypes::Vector::XY.new(-3,-5 ),
                Povray::DataTypes::Vector::XY.new( 3,-5 ),
                Povray::DataTypes::Vector::XY.new( 5,0 ),
                Povray::DataTypes::Vector::XY.new( 3,5 )
            ] ) { |prism|
        prism << Povray::Textures::Pigments::SolidColour.new( Povray::Methods::Colour.new( "Yellow" ) )
        prism << Povray::Methods::Scale.new( 0.15 )
        prism << Povray::Methods::Translate.new( Povray::DataTypes::Vector::XYZ.new(-0.2,0,-0.2) )
    }
}
