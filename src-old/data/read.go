package data

import (
	"encoding/json"
	"io/ioutil"
	"server/log"
)

func Read(input *interface{}, file string) {
	data, err := ioutil.ReadFile(file)
	log.LogFatal(err)

	err = json.Unmarshal(data, input)
	log.LogFatal(err)
}

func Write(input interface{}, file string) {
	data, err := json.Marshal(input)
	log.LogFatal(err)

	err = ioutil.WriteFile(file, data, 0644)
	log.LogFatal(err)
}
