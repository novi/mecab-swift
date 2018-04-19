BUILDOPTS=-Xlinker -L/usr/lib

OS := $(shell uname)
ifeq ($(OS),Darwin)
    BUILDOPTS=-Xlinker -L/usr/local/lib
endif

all: build
	
build:
	$(SWIFT) build $(BUILDOPTS)
	
test:
	$(SWIFT) test $(BUILDOPTS)