require 'povray.rb'
include Povray
include Objects
include FiniteSolidPrimitives
include Atmosphere
include Methods
include LightSources
include Textures

maingroup = Povray::Group.new()

background = Background.new( Colour.new( "Black" ) )

camera = Camera::Basic.new( Location.new( [0, 50, 0] ), LookAt.new( [0, 1, 2] ) )

light = PointLight.new( Vector.new( [12,14,-13] ), Colour.new( "White" ) )

maingroup << '#include "colors.inc"'
maingroup << background
maingroup << camera

radius = 20.0

(0...720).each do |deg|
    degrees = deg*2
    sphere = Sphere.new([degrees/50.0-12.5, 1+radius*Math::cos(Math::PI*degrees/180.0), 2+radius*Math::sin(Math::PI*degrees/180.0)], 0.5)

    texture = Texture.new()
    pigment = Pigments::SolidColour.new( Colour.new( ColourRGB.new( [ degrees/720.0,1,0.5 ] ) ) )
    texture << pigment

    sphere << texture

    maingroup << sphere
    radius -= 0.05
end

maingroup << light

print maingroup
