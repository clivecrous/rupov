require '../../rupov/povray.rb'

if ARGV.length < 1
    puts "You need to supply a data filename."
    exit
end

ConfigFilename = "#{ARGV[0]}.rb"
DataFilename = "#{ARGV[0]}.GeoEAS"

begin
    open(ConfigFilename)
rescue
    puts "Unable to find configuration file: #{ConfigFilename}"
    exit
end

require ConfigFilename

class GeoEAS < Array
    attr_reader :title, :columnAmount, :columns
    def initialize( filename )
        begin
            file = File.new( filename )
        rescue
            puts "Unable to load GeoEAS data file: #{DataFilename}"
            exit
        end
        @title = file.readline.strip
        @columnAmount = file.readline.to_i
        raise "Only 4 colounm GeoEAS data is supported at the moment" if @columnAmount != 4
        @columns=[]
        columnMin=[ 10e100]*4
        columnMax=[-10e100]*4
        (1..@columnAmount).each { @columns << file.readline.strip }
        self.concat file.readlines.map { |line| line.strip.split }.select { |a,b,c,d| d != "-999" }.map { |element| element.map {|a| a.to_f} }.each { |line|
            line.each_index do |index|
                columnMin[index] = line[index] if line[index] < columnMin[index]
                columnMax[index] = line[index] if line[index] > columnMax[index]
            end
        }
        columnMax.each_index { |index| columnMax[index]-=columnMin[index] }
        self.map do |line|
            line.each_index do |index|
                line[index]=((line[index]-columnMin[index])/columnMax[index])-0.5
            end
            line
        end
    end
end

geo = GeoEAS.new(DataFilename)

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
    }.to_s
}

$threshold = "0"
$rotation = "0*y"

puts "Generating scene..."
scene = Povray::Group.new { |scene|
        scene << Povray::Group.new { |prerender|
            prerender << Povray::Methods::Include.new('colors.inc')
            prerender << Povray::Camera::Basic.new(
                        Povray::Methods::Location.new( Povray::DataTypes::Vector::XYZ.new(0.8*CameraDistance,0.8*CameraDistance,1.2*CameraDistance) ),
                        Povray::Methods::LookAt.new( Povray::DataTypes::Vector::XYZ.new(0,0,0) ) )
            prerender << Povray::LightSources::PointLight.new(
                        Povray::DataTypes::Vector::XYZ.new( 5.0*LightDistance,5.0*LightDistance,2.0*LightDistance ), Povray::Methods::Colour.new( "White" ) )
            prerender << Povray::Atmosphere::Background.new( Povray::Methods::Colour.new( "White" ) )
        }.to_s

        blob = Blob ? Povray::Objects::FiniteSolidPrimitives::Blob.new( $threshold ) : Povray::CSG::Union.new
        geo.each { |(x,y,z,mean)|
            colour = ((mean+0.5)*MaxColours).to_i
            colour=MaxColours if colour > MaxColours
            sphere = Povray::Objects::FiniteSolidPrimitives::Sphere.new(
               Povray::DataTypes::Vector::XYZ.new( x*Scale1,z*Scale3,y*Scale2 ), Blob ? BlobRadius : (Radius*((((mean+0.5)*MaxColours)**StrengthPower)/(MaxColours**StrengthPower))).to_s+"*") { |sphere|
                   sphere << $threshold if not Blob
                   sphere << Povray::Group.new { |prerender|
                       prerender << (((mean+0.5)*MaxColours)**StrengthPower)/(MaxColours**StrengthPower) if Blob
                       prerender << colours[colour]
                   }.to_s
            }
            if Blob
                blob << sphere.to_s
            else
                blob << sphere
            end
        }
        blob << Povray::Methods::Rotate.new( $rotation )
        scene << blob
}

(1..Frames).each { |frame|
    puts "Generating frame #{frame} of #{Frames}"
    $threshold.replace "#{((frame*2-Frames).to_f/Frames).abs/3+0.01}"
    $rotation.replace "#{(frame.to_f/Frames)*360}*y"
    tow = scene.to_s
    File.new(("statistical_data_%%0%dd.pov"%Frames.to_s.length)%frame,"w").write( tow )
}
