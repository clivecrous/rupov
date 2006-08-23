WIDTH = 1024
HEIGHT = 768

POVRAY = povray -D Width=$(WIDTH) Height=$(HEIGHT)

PNGFILES = $(subst .rb,.png,$(wildcard *.rb))
POVFILES = $(subst .rb,.pov,$(wildcard *.rb))

.PHONY: all clean

default: all

all: $(PNGFILES)

$(PNGFILES): %.png: %.pov
	$(POVRAY) $<

$(POVFILES): %.pov: %.rb include/genericscene.rb ../rupov/povray.rb
	ruby $< >$@

clean:
	rm -f *.pov *.png
