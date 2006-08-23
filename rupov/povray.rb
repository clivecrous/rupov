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

        module FiniteSolidPrimitives

            class Box < Base
                def initialize( lowerLeftCorner, upperRightCorner )
                    super( 'box' )
                    self << Methods::Vector.new( lowerLeftCorner)
                    self << Methods::Vector.new( upperRightCorner )
                end
            end

            class Cone < Base
                def initialize( leftCentre, leftRadius, rightCentre, rightRadius, open = false )
                    super( 'cone' )
                    self << Methods::VectorRadius.new( leftCentre, leftRadius )
                    self << Methods::VectorRadius.new( rightCentre, rightRadius )
                    self << "open" if open
                end
            end

            class Cylinder < Base
                def initialize( leftCentre, rightCentre, radius, open = false )
                    super( 'cylinder' )
                    self << "#{Methods::Vector.new( leftCentre )},#{Methods::Vector.new( rightCentre )},#{radius}"
                    self << "open" if open
                end
            end

            class Lathe < Base
                def initialize( points, splineType = "linear_spline", sturm = false )
                    super( 'lathe' )
                    self << "#{splineType} #{points.length}, #{points.join(', ')}"
                    self << "sturm" if sturm
                end
            end
            
            class Sphere < Base
                def initialize( centre, radius )
                    super( 'sphere' )
                    self << Methods::VectorRadius.new( centre, radius)
                end
            end

            class Torus < Base
                def initialize( majorRadius, minorRadius )
                    super( 'torus')
                    self << "#{majorRadius}, #{minorRadius}"
                end
            end
        end

        module InfiniteSolidPrimitives
            class Plane < Base
                def initialize( vector, displacement )
                    super( 'plane' )
                    self << Methods::VectorRadius.new( vector, displacement )
                end
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

    module CSG

        class Difference < Base
            def initialize
                super( 'difference' )
            end
        end
        
        class Union < Base
            def initialize
                super( 'union' )
            end
        end

        class Merge < Base
            def initialize
                super( 'merge' )
            end
        end

        class Intersection < Base
            def initialize
                super( 'intersection' )
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
        
        class Checker
            def initialize( colour1, colour2 )
                @colour1 = colour1
                @colour2 = colour2
            end
            def to_s
                "checker #{@colour1}, #{@colour2}"
            end

        end
    end
end
