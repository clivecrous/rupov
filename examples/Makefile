WIDTH = 800
HEIGHT = 600

POVRAY = povray Width=$(WIDTH) Height=$(HEIGHT)

.PHONY: all clean

default: all

all: test1.png

test1.png: test1.pov
	$(POVRAY) test1.pov

test1.pov: test1.rb ../rupov/povray.rb
	ruby test1.rb >$@

clean:
	rm -f *.pov *.png
