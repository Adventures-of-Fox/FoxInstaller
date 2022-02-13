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
		Init()
		Scripts()
	case "update":
		misc.TODO("Updating")
	default:
		log.LogError(errors.New("command flag \"%v\" is unknown"), cmd.Type)
	}
}

func Scripts() {
	if misc.CheckOS() == "win" {
		Win()
	} else {
		Unix()
	}
}
