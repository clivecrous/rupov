require 'povray.rb'
include Povray::Objects
include Povray::Methods

file = Povray::File.new()

background = Background.new()
background << Colour.new( "Black" )

camera = Camera.new()
camera << Location.new( [0, 50, 0] )
camera << LookAt.new( [0, 1, 2] )

light = LightSource.new()
light << Vector.new( [12,14,-13] )
light << Colour.new( "White" )

file << '#include "colors.inc"'
file << background
file << camera

radius = 20.0

(0...720).each do |deg|
    degrees = deg*2
    sphere = Sphere.new()
    sphere <<::LocationRadius.new( [degrees/50.0-12.5, 1+radius*Math::cos(Math::PI*degrees/180.0), 2+radius*Math::sin(Math::PI*degrees/180.0)], 0.5 )

    texture = Texture.new()
    pigment = Pigment.new()
    pigment << Colour.new( ColourRGB.new( [ degrees/720.0,1,0.5 ] ) ) 
    texture << pigment

    sphere << texture

    file << sphere
    radius -= 0.05
end

file << light

print file
