require '../../rupov/povray.rb'

Frames = 200 
MaxColours = 2000

class GeoEAS < Array
    attr_reader :title, :columnAmount, :columns
    def initialize( filename )
        file = File.new( filename )
        @title = file.readline.strip
        @columnAmount = file.readline.to_i
        @columns=[]
        (1..@columnAmount).each { @columns << file.readline.strip }
        self.concat file.readlines.map { |line| line.strip.split }.select { |a,b,c,d| d != "-999" }.map { |element| element.map {|a| a.to_f} }
    end
end

geo = GeoEAS.new("statistical_data.GeoEAS")

colours = []
(0..MaxColours).each { |colournum|
    colours << Povray::Textures::Texture.new { |texture|
        texture << Povray::Textures::Pigments::SolidColour.new(
            Povray::Methods::ColourRGB.new(
                Povray::DataTypes::Vector::RGB.new(
                    1.0+((colournum.to_f)/MaxColours)/2,
                    1-((colournum.to_f)/MaxColours),
                    0)))
        texture << Povray::Textures::Finish.new { |finish|
            finish << Povray::Methods::Ambient.new(0.1)
            finish << Povray::Methods::Brilliance.new(3)
            finish << Povray::Methods::Diffuse.new(0.7)
            finish << Povray::Methods::Metallic.new
            finish << Povray::Methods::Specular.new(1.4)
            finish << Povray::Methods::Roughness.new(1.0/120)
        }
    }
}

$threshold = "0"
$rotation = "0*y"

StrengthPower = 1.75

puts "Generating scene..."
scene = Povray::Group.new { |scene|
        scene << Povray::Methods::Include.new('colors.inc')
        scene << Povray::Camera::Basic.new(
                    Povray::Methods::Location.new( Povray::DataTypes::Vector::XYZ.new(1,1.75,2) ),
                    Povray::Methods::LookAt.new( Povray::DataTypes::Vector::XYZ.new(0,0.25,0) ) )
        scene << Povray::LightSources::PointLight.new(
                    Povray::DataTypes::Vector::XYZ.new( 5,5,2 ), Povray::Methods::Colour.new( "White" ) )
        scene << Povray::Atmosphere::Background.new( Povray::Methods::Colour.new( "White" ) )

        scene << Povray::Objects::FiniteSolidPrimitives::Blob.new( $threshold ) { |blob|
            geo.each { |(x,y,z,mean)|
                x=x/75-0.8; y=y/75-0.8; z/=20
                colour = (mean**1.1).to_i
                colour=MaxColours if colour > MaxColours
                blob << Povray::Objects::FiniteSolidPrimitives::Sphere.new(
                   Povray::DataTypes::Vector::XYZ.new( x,z,y ), 0.1 ) { |sphere|
                       sphere << (mean.to_f**StrengthPower)/(MaxColours**StrengthPower)
                       sphere << colours[colour]
                }
            }
            blob << Povray::Methods::Rotate.new( $rotation )
        }
}

(1..Frames).each { |frame|
    puts "Generating frame #{frame} of #{Frames}"
    $threshold.replace "#{((frame*2-Frames).to_f/Frames).abs/3+0.01}"
    $rotation.replace "#{(frame.to_f/Frames)*360}*y"
    tow = scene.to_s
    File.new(("statistical_data_%%0%dd.pov"%Frames.to_s.length)%frame,"w").write( tow )
}
