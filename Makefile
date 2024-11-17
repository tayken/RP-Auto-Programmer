.PHONY: build

build:
	mkdir -p build
	sed "s:<user>:$(USER):" 10-udisks-rp-auto.pkla > build/10-udisks-rp-auto.pkla
	sed "s:<user>:$(USER):" 10-udisks-rp-auto.rules > build/10-udisks-rp-auto.rules
	sed "s:<path>:$(CURDIR)/build:" rp-auto-program@.service | sed "s:<user>:$(USER):" > build/rp-auto-program@.service
	sed "s:<path>:$(CURDIR):" rp-program-shim.sh > build/rp-program-shim.sh
	sed -r "s:^(SCRIPT_PATH=).*:\1$(CURDIR):" rp-program.sh > build/rp-program.sh
	chmod +x build/*.sh

install:
	if [ -d /etc/polkit-1/rules.d/ ]; then cp build/10-udisks-rp-auto.rules /etc/polkit-1/rules.d/; \
	elif [ -d /etc/polkit-1/localauthority/50-local.d/ ]; then cp build/10-udisks-rp-auto.pkla /etc/polkit-1/localauthority/50-local.d/; fi
	systemctl restart polkit.service
	cp 99-rp-auto-program.rules /etc/udev/rules.d/
	udevadm control --reload
	cp build/rp-auto-program@.service /etc/systemd/system/
	systemctl daemon-reload

clean:
	rm -rf build

uninstall:	
	if [ -f /etc/polkit-1/rules.d/10-udisks-rp-auto.rules ]; then rm /etc/polkit-1/rules.d/10-udisks-rp-auto.rules; fi
	if [ -f /etc/polkit-1/localauthority/50-local.d/10-udisks-rp-auto.pkla ]; then rm /etc/polkit-1/localauthority/50-local.d/10-udisks-rp-auto.pkla; fi
	systemctl restart polkit.service
	rm /etc/udev/rules.d/99-rp-auto-program.rules 
	udevadm control --reload
	rm /etc/systemd/system/rp-auto-program@.service 
	systemctl daemon-reload
