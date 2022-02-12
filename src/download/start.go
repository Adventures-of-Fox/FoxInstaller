package download

import (
	"errors"
	"server/cmd"
	"server/log"
	"server/misc"
)

func Server() {
	switch cmd.Type {
	case "init":
		misc.TODO("Initial")
		Scripts()
	case "update":
		misc.TODO("Updating")
	default:
		log.LogError(errors.New("command flag \"%v\" is unknown"), cmd.Type)
	}
}

func Scripts() {
	if misc.CheckOS() == "win" {
		misc.TODO("Script windows")
	} else {
		misc.TODO("Script unix (linux,macos)")
	}
}
