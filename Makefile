# Variabel

PROTOC=protoc
PROTO_DIR=proto
GEN_DIR=protogen
GO_MODULE=github.com/achtarudin/grpc-cutbray

# Menemukan semua file .proto secara otomatis
# PROTO_FILES=$(wildcard $(PROTO_DIR)/**/*.proto)
PROTO_FILES=$(shell find $(PROTO_DIR) -type f -name '*.proto')


.PHONY: all protos clean

all: protos

# Target untuk generate kode protobuf
protos:
	@echo "Generating Protobuf files..."

	$(PROTOC) \
    --go_out=. --go_opt=module=$(GO_MODULE) \
    --go-grpc_out=. --go-grpc_opt=module=$(GO_MODULE) \
    $(PROTO_FILES) 
	
	@echo "Done."

# Target untuk membersihkan file yang di-generate
clean:
	@echo "Cleaning generated files..."
	rm -rf $(GEN_DIR)
	@echo "Done."
