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
                    self << "#{leftCentre},#{leftRadius}"
                    self << "#{rightCentre},#{rightRadius}"
                    self << "open" if open
                end
            end

            class Cylinder < Base
                def initialize( leftCentre, rightCentre, radius, open = false )
                    super( 'cylinder' )
                    self << "#{leftCentre},#{rightCentre},#{radius}"
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
                def initialize( majorRadius, minorRadius, sturm = false )
                    super( 'torus')
                    self << "#{majorRadius}, #{minorRadius}"
                    self << "sturm" if sturm
                end
            end
        end

        module FinitePatchPrimitives
            class Disc < Base
                def initialize( centre, normal, radius, holeRadius=0.0 )
                    super( 'disc' )
                    initline = "#{centre}, #{normal}, #{radius}"
                    initline += ", #{holeRadius}" if holeRadius != 0.0
                    self << initline
                end
            end

            class Polygon < Base
                def initialize( points )
                    super( 'polygon' )
                    self << "#{points.length}, #{points.join(', ')}"
                end
            end

            class Triangle < Base
                def initialize( corner1, corner2, corner3 )
                    super( 'triangle' )
                    self << "#{corner1}, #{corner2}, #{corner3}"
                end
            end

            class SmoothTriangle < Base
                def initialize( corner1, normal1, corner2, normal2, corner3, normal3 )
                    super( 'smooth_triangle' )
                    self << "#{corner1}, #{normal1}, #{corner2}, #{normal2}, #{corner3}, #{normal3}"
                end
            end
        end
        
        module InfiniteSolidPrimitives
            class Plane < Base
                def initialize( normal, distance )
                    super( 'plane' )
                    self << "#{normal}, #{distance}"
                end
            end
        end
    end

    module LightSources

        class LightSource < Base
            def initialize
                super( 'light_source' )
            end
        end

        class LightGroup < Base
            def initialize
                super( 'light_group' )
            end
        end
        
        class PointLight < LightSource
            def initialize( location, colour )
                super()
                self << "#{location}, #{colour}"
            end
        end

    end

    module Atmosphere
        class Background < Base
            def initialize( colour )
                super( 'background' )
                self << colour
            end
        end
    end

    module Camera
        class Camera < Base
            def initialize
                super( 'camera' )
            end
        end

        class Basic < Camera
            def initialize( location, direction )
                # direct could be Methods::LookAt or Methods::Direction
                super()
                self << location
                self << direction
            end
        end
    end
    
    module Textures

        class Texture < Base
            def initialize
                super( 'texture' )
            end
        end

        module Pigments
            class Pigment < Base
                def initialize
                    super( 'pigment' )
                end
            end

            class SolidColour < Pigment
                def initialize( colour )
                    super()
                    self << colour
                end
            end

            class ColourList < Pigment
                def initialize( type, list )
                    super()
                    self << "#{type} #{list.join(',')}"
                end
            end

            class Brick < ColourList
                def initialize( colour1, colour2 )
                    super( "brick", [colour1,colour2] )
                end
            end

            class Checker < ColourList
                def initialize( colour1, colour2 )
                    super( "checker", [colour1,colour2] )
                end
            end

            class Hexagon < ColourList
                def initialize( colour1, colour2, colour3 )
                    super( "hexagon", [colour1,colour2,colour3] )
                end
            end
        end

        class Normal < Base
            def initialize
                super( 'normal')
            end
        end

        class Finish < Base
            def initialize
                super( 'finish' )
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

        class Rotate < Vector
            def initialize( vector )
                super( vector, 'rotate' )
            end
        end

        class Scale < Vector
            def initialize( vector )
                super( vector, 'scale' )
            end
        end

        class Translate < Vector
            def initialize( vector )
                super( vector, 'translate' )
            end
        end

        class LookAt < Vector
            def initialize( lookat )
                super( lookat, 'look_at' )
            end
        end

        class Direction < Vector
            def initialize( lookat )
                super( lookat, 'direction' )
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
        
        class Reflection
            def initialize( colour )
                @colour = colour
            end
            def to_s
                "reflection #{@colour}"
            end
        end

    end
end
