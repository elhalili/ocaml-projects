OCAMLC=ocamlc
BUILD_DIR=build
EXEC=$(BUILD_DIR)/main

SRC_FILES=tabulation.ml memoization.ml naive.ml main.ml
OBJ_FILES=$(SRC_FILES:.ml=.cmo)
OBJ_FILES_BUILD=$(addprefix $(BUILD_DIR)/, $(OBJ_FILES))


all: $(EXEC)

$(BUILD_DIR)/%.cmo: %.ml
	mkdir -p $(BUILD_DIR)
	$(OCAMLC) -c $< -o $@

$(BUILD_DIR)/main.cmo: main.ml $(OBJ_FILES_BUILD)
	$(OCAMLC) -I $(BUILD_DIR) -c $< -o $@

$(EXEC): $(OBJ_FILES_BUILD)
	$(OCAMLC) -o $(EXEC) -I $(BUILD_DIR) $^

clean:
	rm -rf $(BUILD_DIR)

.PHONY: all clean
