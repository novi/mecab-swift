BUILDOPTS=-Xlinker -L/usr/lib

OS := $(shell uname)
ifeq ($(OS),Darwin)
    BUILDOPTS=-Xlinker -L/usr/local/lib
endif

all: build
	
build:
	swift build $(BUILDOPTS)
	
test:
	swift test $(BUILDOPTS)