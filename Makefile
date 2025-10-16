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

	$(PROTOC) -I .\
    --go_out=. --go_opt=module=$(GO_MODULE) \
    --go-grpc_out=. --go-grpc_opt=module=$(GO_MODULE) \
    $(PROTO_FILES) 
	
	@echo "Done."

# Target untuk membersihkan file yang di-generate
clean:
	@echo "Cleaning generated files..."
	rm -rf $(GEN_DIR)
	@echo "Done."


.PHONY: clean-gateway
clean-gateway:
	rm -fR ./protogen/gateway 
	mkdir -p ./protogen/gateway/go
	mkdir -p ./protogen/gateway/openapiv2

.PHONY: protoc-go-gateway
protoc-go-gateway:
	$(PROTOC) -I . \
	--grpc-gateway_out ./protogen/gateway/go \
	--grpc-gateway_opt logtostderr=true \
	--grpc-gateway_opt paths=source_relative \
	--grpc-gateway_opt grpc_api_configuration=./grpc-gateway/config.yml \
	--grpc-gateway_opt standalone=true \
	--grpc-gateway_opt generate_unbound_methods=true \
	$(PROTO_FILES) 

.PHONY: build-gateway
build-gateway: clean-gateway protoc-go-gateway
