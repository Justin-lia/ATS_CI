############################################################
#
#  BUFFALO CONFIDENTIAL
#
#  Copyright 1998-2022 Buffalo Inc. All rights reserved
#
############################################################

PROG=Ubuntu_MAP-E_Test-server
VERSION = $(shell cat 0_README.txt | grep Test-Server | head -n1 | awk '{print $$5}')

.PHONY: release
release: release/$(VERSION)

release/$(VERSION):
	mkdir -p "release/$(VERSION)"
	tar \
		--exclude release \
		-zcvf "./release/$(VERSION)/$(PROG)_$(VERSION).tar.gz" -C ../ $(PROG)

