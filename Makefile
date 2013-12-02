C = \:
# do not change C


PREFIX = /usr
DATA = /share
PKGNAME = pony-artwork

SYSLINUX_VESAMENU = y
BRANDED = y
UNBRANDED = y
PREVIEWS = y
ASPECT = 4$(C)3 16$(C)9


DIR = $(DESTDIR)$(PREFIX)$(DATA)/$(PKGNAME)



.PHONY: all install uninstall clean
all:
install:
uninstall:
clean:



#### SYSLINUX vesamenu themss

ifeq ($(SYSLINUX_VESAMENU),y)

SYSLINUX_VESAMENU_SRC =

ifeq ($(BRANDED),y) ## GNU/Pony branded SYSLINUX vesamenu themes

SYSLINUX_VESAMENU_SRC += \
    apple-bloom \
    discord+amused discord+float discord+happy discord+throne \
    fluttershy+angry fluttershy+crystal fluttershy+dance fluttershy+excited \
    fluttershy+fly fluttershy+happy fluttershy+hoof fluttershy+sing fluttershy+snuggle \
    fyrefly \
    luna+cloud luna+young \
    mascot \
    pinkie-pie+angry pinkie-pie+hay pinkie-pie+smiling \
    rainbow-dash+adore rainbow-dash+fly rainbow-dash+relax rainbow-dash+whatever \
    scootaloo \
    spike+diamond spike+dragon spike+hug spike+look spike+smile \
    sweetie-belle \
    twilight+excited twilight+new-wings twilight+proud

endif

ifeq ($(UNBRANDED),y) ## Unbranded SYSLINUX vesamenu themes
endif

SYSLINUX_VESAMENU_SRC_ALL = $(foreach S, $(SYSLINUX_VESAMENU_SRC), $(foreach A, $(ASPECT), SYSLINUX/vesamenu/$(A)/$(S)))

all: $(foreach S, $(SYSLINUX_VESAMENU_SRC_ALL), $(S)/splash.png)

SYSLINUX/vesamenu/%/splash.png: SYSLINUX/vesamenu/%/splash.xcf.bz2
	cd "$(shell dirname "$@")" && make splash.png

ifeq ($(PREVIEWS),y)

.PHONY: install-syslinux-vesamenu-preview
install: install-syslinux-vesamenu-preview
install-syslinux-vesamenu-preview: $(foreach S, $(SYSLINUX_VESAMENU_SRC_ALL), $(S)/preview.png)
	install -dm755 -- $(foreach S, $(SYSLINUX_VESAMENU_SRC_ALL), "$(DIR)"/$(S))
	for S in $(SYSLINUX_VESAMENU_SRC_ALL); do \
	    install -m644 -- $$S/preview.png "$(DIR)"/$$S || exit 1; \
	done

.PHONY: uninstall-syslinux-vesamenu-preview
uninstall: uninstall-syslinux-vesamenu-preview
uninstall-syslinux-vesamenu-preview:
	-rm -- $(foreach S, $(SYSLINUX_VESAMENU_SRC_ALL), "$(DIR)"/$(S)/preview.png)

endif

.PHONY: install-syslinux-vesamenu
install: install-syslinux-vesamenu
install-syslinux-vesamenu: $(foreach S, $(SYSLINUX_VESAMENU_SRC_ALL), $(S)/splash.png $(S)/syslinux.cfg)
	install -dm755 -- $(foreach S, $(SYSLINUX_VESAMENU_SRC_ALL), "$(DIR)"/$(S))
	for S in $(SYSLINUX_VESAMENU_SRC_ALL); do \
	    install -m644 -- "$$S/splash.png" "$$(realpath "$$S/syslinux.cfg")" "$(DIR)/"$$S || exit 1; \
	done

.PHONY: uninstall-syslinux-vesamenu
uninstall: uninstall-syslinux-vesamenu
uninstall-syslinux-vesamenu:
	-rm -- $(foreach S, $(SYSLINUX_VESAMENU_SRC_ALL), "$(DIR)"/$(S)/splash.png "$(DIR)"/$(S)/syslinux.cfg)
	-rmdir -- $(foreach S, $(SYSLINUX_VESAMENU_SRC_ALL), "$(DIR)"/$(S))
	-rmdir -- $(foreach A, $(ASPECT), "$(DIR)"/SYSLINUX/vesamenu/$(A))
	-rmdir -- "$(DIR)/SYSLINUX/vesamenu"
	-rmdir -- "$(DIR)/SYSLINUX"
	-rmdir -- "$(DIR)"

.PHONY: clean-syslinux-vesamenu
clean: clean-syslinux-vesamenu
clean-syslinux-vesamenu:
	-for S in $(SYSLINUX_VESAMENU_SRC_ALL); do cd "$$S" && make clean ; cd - ; done

endif

