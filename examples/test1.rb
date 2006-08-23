require 'povray.rb'
include Povray

include Objects
include FiniteSolidPrimitives
include FinitePatchPrimitives

include Atmosphere
include Methods
include LightSources
include Textures

spheres = CSG::Merge.new()
radius = 20.0

(0...720).each do |deg|
    degrees = deg*4
    sphere = Sphere.new([degrees/100.0-12.5, 1+radius*Math::cos(Math::PI*degrees/180.0), 2+radius*Math::sin(Math::PI*degrees/180.0)], (radius.abs)/20)

    texture = Texture.new()
    texture << Pigments::SolidColour.new( Colour.new( ColourRGBT.new( [ degrees/720.0,1,0.5,0.85 ] ) ) )

    sphere << texture

    spheres << sphere
    radius -= 0.05
end

spheres << "interior { ior Ruby_Ior }"

scene = Povray::Group.new()

scene << '#include "colors.inc"'
scene << '#include "textures.inc"'
scene << '#include "glass.inc"'

scene << Background.new( Colour.new( "Black" ) )
scene << Camera::Basic.new( Location.new( [15, 15, 20] ), LookAt.new( [0, 0, 0] ) )

scene << PointLight.new( Vector.new( [-12,20,13] ), Colour.new( "White" ) )
scene << PointLight.new( Vector.new( [12,-10,130] ), Colour.new( "White" ) )

disc = Cylinder.new( Vector.new( [0,0,0] ), Vector.new( [0,0.1,0] ), 20 )
disc_texture = Texture.new()
disc_texture << "T_Glass1"
disc_texture << "finish { Shiny }"
disc << disc_texture
disc << "interior { ior Flint_Glass_Ior }"

scene << disc
scene << spheres

print scene
