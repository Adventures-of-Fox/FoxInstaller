package log

import (
	"log"
	"server/misc"

	"github.com/ztrue/tracerr"
)

func LogFatal(err error, v ...interface{}) {
	if err != nil {
		err = tracerr.Wrap(err)
		msg := tracerr.SprintSourceColor(err)
		log.Fatalf(misc.Redbold(msg), v...)
	}
}

func LogInfo(msg string, v ...interface{}) {
	log.Printf(misc.Blue(msg), v...)
}

func LogError(err error, v ...interface{}) {
	if err != nil {
		err = tracerr.Wrap(err)
		log.Fatalf(misc.Redbold(err.Error()), v...)
	}
}
