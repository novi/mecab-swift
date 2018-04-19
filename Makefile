BUILDOPTS=-Xlinker -L/usr/lib

SWIFTC=swiftc
SWIFT=swift
ifdef SWIFTPATH
    SWIFTC=$(SWIFTPATH)/bin/swiftc
    SWIFT=$(SWIFTPATH)/bin/swift
endif
OS := $(shell uname)
ifeq ($(OS),Darwin)
    BUILDOPTS=
endif

all: build
	
build:
	$(SWIFT) build $(BUILDOPTS)
	
test:
	$(SWIFT) test $(BUILDOPTS)