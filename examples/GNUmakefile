WIDTH = 800
HEIGHT = 600

POVRAY = povray Width=$(WIDTH) Height=$(HEIGHT)

.PHONY: all clean

default: all

all: $(subst .rb,.png, $(wildcard *.rb) )

%.png: %.pov
	$(POVRAY) $<

%.pov: %.rb genericscene.rb ../rupov/povray.rb
	ruby $< >$@

clean:
	rm -f *.pov *.png
