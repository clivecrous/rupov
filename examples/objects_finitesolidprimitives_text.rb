require '../rupov/povray.rb'
require 'include/genericscene.rb'

puts Scene.new() { |scene|
    scene << Povray::Objects::FiniteSolidPrimitives::Text.new(
            "crystal.ttf","rupov",0.1) { |text|
        text << Povray::Textures::Pigments::SolidColour.new( Povray::Methods::Colour.new( "Yellow" ) )
        text << Povray::Methods::Scale.new( 0.7 )
        text << Povray::Methods::Translate.new( "x*-0.8" )
        text << Povray::Methods::Rotate.new( "y*210" )
        text << Povray::Methods::Translate.new( "y*0.15" )
    }
}
