CMecab=CMeCab-1.0.0
BUILDOPTS=-Xlinker -L/usr/lib -Xcc -IPackages/$(CMecab)

SWIFTC=swiftc
SWIFT=swift
ifdef SWIFTPATH
    SWIFTC=$(SWIFTPATH)/bin/swiftc
    SWIFT=$(SWIFTPATH)/bin/swift
endif
OS := $(shell uname)
ifeq ($(OS),Darwin)
    SWIFTC=xcrun -sdk macosx swiftc
	BUILDOPTS=-Xcc -IPackages/$(CMecab) -Xlinker -L/usr/local/lib
endif

all: build
	
build:
	$(SWIFT) build -v $(BUILDOPTS)
	
test:
	$(SWIFT) test
