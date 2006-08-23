require '../rupov/povray.rb'
require 'include/genericscene.rb'

puts Scene.new() { |scene|
    scene << Povray::Objects::FiniteSolidPrimitives::SphereSweep.new(
            [   Povray::DataTypes::Vector::XYZ.new( 0, -0.1, 0), 0.1,
                Povray::DataTypes::Vector::XYZ.new( 0, 0, 0), 0.1,
                Povray::DataTypes::Vector::XYZ.new( -0.5, 0.25, 0), 0.075,
                Povray::DataTypes::Vector::XYZ.new( -0.5, 0.5, 0.5), 0.05,
                Povray::DataTypes::Vector::XYZ.new( 0.5, 0.75, 0.5), 0.025,
                Povray::DataTypes::Vector::XYZ.new( 0.5, 1, -0.5), 0.001,
                Povray::DataTypes::Vector::XYZ.new( 0, 1, 0), 0
            ], 'b_spline' ) { |spheresweep|
        spheresweep << Povray::Textures::Pigments::SolidColour.new( Povray::Methods::Colour.new( "Yellow" ) )
    }
}
