package main

import (
	"fmt"
	"log"
	"os"
	"os/exec"
)

func main() {
	if len(os.Args) != 2 {
		os.Exit(1)
	}
	name := os.Args[1]

	f, err := os.Create("Makefile")
	if err != nil {
		log.Fatalln(err)
	}
	fmt.Fprintf(f, makefileTemplate, name)
	f.Close()

	f, err = os.Create("Dockerfile")
	if err != nil {
		log.Fatalln(err)
	}
	fmt.Fprint(f, dockerfileTemplate)
	f.Close()

	f, err = os.Create(".drone.yml")
	if err != nil {
		log.Fatalln(err)
	}
	fmt.Fprint(f, droneTemplate)
	f.Close()

	f, err = os.Create("README.md")
	if err != nil {
		log.Fatalln(err)
	}
	fmt.Fprintf(f, readmeTemplate, name)
	f.Close()

	f, err = os.Create("LICENSE")
	if err != nil {
		log.Fatalln(err)
	}
	fmt.Fprint(f, licenseTemplate)
	f.Close()

	cmd := exec.Command("git", "init")
	if err := cmd.Run(); err != nil {
		log.Fatalln(err)
	}
}
