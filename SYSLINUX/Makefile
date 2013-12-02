XCF2PNG = xcf2png
# `xcf2png` is provided by `xcftools`

SPLASHTOOL = splashtool
# `splashtool` is provided by `splashtool`

WIDE = 
# Set to `-w` if preview is in 16:9


.PHONY: all
all: splash.png

splash.png: splash.xcf.bz2
	$(XCF2PNG) "$<" --output "$@"


.PHONY: preview preview-w
preview: preview.png
preview-w: WIDE=-w
preview-w: preview.png

preview.png: splash.png syslinux.cfg
	$(SPLASHTOOL) syslinux.cfg "$@" $(WIDE)


.PHONY: clean
clean:
	-rm splash.png

