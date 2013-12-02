XCF2PNG = xcf2png
# `xcf2png` is provided by `xcftools`

.PHONY: all
all: splash.png

splash.png: splash.xcf.bz2
	$(XCF2PNG) "$<" --output "$@"

.PHONY: clean
clean:
	-rm splash.png

