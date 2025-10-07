package main

import "github.com/achtarudin/grpc-cutbray/protogen/sample"

func main() {
	hello := &sample.Hello{}
	hello.SetName("Achtarudin")

	name := "Achtarudin"
	hello1 := sample.Hello_builder{
		Name: &name,
	}.Build()

	println(hello1.GetName())
	println(hello.GetName())
}
