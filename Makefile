PROJECT = neewer-controller
SRC := $(PROJECT).yaml
BIN := bin/$(PROJECT)-factory.bin

.PHONY: all clean

all: $(BIN)

bin/:
	mkdir bin/

$(BIN): $(SRC) bin/
	docker run --rm --privileged -v "${PWD}":/config -it esphome/esphome compile $<
	cp .esphome/build/$(PROJECT)/.pioenvs/$(PROJECT)/firmware-factory.bin $@

clean: $(SRC)
	docker run --rm --privileged -v "${PWD}":/config -it esphome/esphome clean $<
	rm $(BIN)
