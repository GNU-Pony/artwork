CONVERT = convert
# `convert` is provided by `imagemagick`

.PHONY: all
all: splash.png

splash.png: splash.xcf.bz2
	$(CONVERT) -flatten "$<" "$@"

.PHONY: clean
clean:
	-rm splash.png

