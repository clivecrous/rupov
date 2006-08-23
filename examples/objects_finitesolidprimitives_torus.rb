require '../rupov/povray.rb'
require 'include/genericscene.rb'

scene = Scene.new()

torus =
    Povray::Objects::FiniteSolidPrimitives::Torus.new( 0.85, 0.3 )

torus << Povray::Textures::Pigments::SolidColour.new( Povray::Methods::Colour.new( "Yellow" ) )

torus << Povray::Methods::Translate.new( 0, 0.5, 0)

scene << torus

puts scene
