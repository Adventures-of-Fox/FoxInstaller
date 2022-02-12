package cmd

import (
	"flag"
	"strings"
)

type cmd struct {
	Type string
}

var Type = func() string {
	flagsCmd := flag.String("type", "init", "Starting flag")
	flag.Parse()
	return strings.ToLower(*flagsCmd)
}()

func Cmd() cmd {
	cmdFlags := cmd{
		Type: Type,
	}
	return cmdFlags
}
