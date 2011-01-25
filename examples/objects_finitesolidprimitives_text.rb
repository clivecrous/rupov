require 'rupov'
require './include/genericscene'

puts Scene.new() { |scene|
    scene << RuPov::Objects::FiniteSolidPrimitives::Text.new(
            "crystal.ttf","rupov",0.1) { |text|
        text << RuPov::Textures::Pigments::SolidColour.new( RuPov::Methods::Colour.new( "Yellow" ) )
        text << RuPov::Methods::Scale.new( 0.7 )
        text << RuPov::Methods::Translate.new( "x*-0.8" )
        text << RuPov::Methods::Rotate.new( "y*210" )
        text << RuPov::Methods::Translate.new( "y*0.15" )
    }
}
