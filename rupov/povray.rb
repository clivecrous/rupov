module Povray

    class Base
        attr_reader :name
        def initialize( name='' )
            @name = name
            @children = []
        end
        def to_s
            children = ''
            @children.each { |child| child.to_s.each { |line| children += " "*4+line.rstrip+"\n" } }
            "#{name}#{name.length>0?' ':''}{\n#{children}}"
        end
        def <<( child )
            @children << child
        end
    end

    class Group < Base
        def initialize
            super( '' )
        end
        def to_s
            children = ''
            @children.each { |child| child.to_s.each { |line| children += line.rstrip+"\n" } }
            "#{children}"
        end
    end

    module Objects

        class Sphere < Base
            def initialize
                super( 'sphere' )
            end
        end

        class LightSource < Base
            def initialize
                super( 'light_source' )
            end
        end

        class Texture < Base
            def initialize
                super( 'texture' )
            end
        end

        class Pigment < Base
            def initialize
                super( 'pigment' )
            end
        end

        class Background < Base
            def initialize
                super( 'background' )
            end
        end

        class Camera < Base
            def initialize
                super( 'camera' )
            end
        end
    end

    module Methods

        class Vector
            attr_reader :name
            def initialize( items, name='' )
                @name = name
                @items = items
            end
            def to_s
                "#{name}#{name.length>0?' ':''}<#{@items.join(',')}>"
            end
        end

        class VectorRadius < Vector
            def initialize( items, radius, name='' )
                super( items, '' )
                @radius = radius
            end
            def to_s
                "#{super}, #{@radius}"
            end
        end

        class Location < Vector
            def initialize( location )
                super( location, 'location' )
            end
        end

        class LookAt < Vector
            def initialize( lookat )
                super( lookat, 'look_at' )
            end
        end

        class Colour
            def initialize( colour )
                @colour = colour
            end
            def to_s
                "colour #{@colour}"
            end
        end

        class ColourRGB < Vector
            def initialize( rgb )
                super( rgb, 'rgb' )
            end
        end

        class ColourRGBF < Vector
            def initialize( rgbf )
                super( rgbf, 'rgbf' )
            end
        end

        class ColourRGBT < Vector
            def initialize( rgbt )
                super( rgbt, 'rgbt' )
            end
        end

        class ColourRGBFT < Vector
            def initialize( rgbft )
                super( rgbft, 'rgbft' )
            end
        end
        
    end
end
