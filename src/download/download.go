package download

import (
	"bytes"
	"io"
	"math"
	"net/http"
	"os"
	"path"
	"server/log"
	"strconv"
	"time"

	"github.com/schollz/progressbar/v3"
)

func PrintDownloadPercent(done chan int64, path string, total int64) {
	var stop bool = false

	bar := progressbar.NewOptions(100,
		progressbar.OptionEnableColorCodes(true),
		progressbar.OptionSetWidth(25),
		progressbar.OptionSetTheme(progressbar.Theme{
			Saucer:        "[blue]=[reset]",
			SaucerHead:    "[cyan]>[reset]",
			SaucerPadding: " ",
			BarStart:      "[",
			BarEnd:        "]",
		}))

	for {
		select {
		case <-done:
			stop = true
		default:

			file, err := os.Open(path)

			log.LogFatal(err)

			fi, err := file.Stat()

			log.LogFatal(err)

			size := fi.Size()

			if size == 0 {
				size = 1
			}

			var percent float64 = float64(size) / float64(total) * 100
			prc := int(math.Round(percent))

			bar.Set(prc)
			bar.RenderBlank()
		}

		if stop {
			bar.Set(100)
			break
		}

		time.Sleep(time.Second)
	}
}

func DownloadFile(url string, dest string) {

	file := path.Base(url)

	log.LogInfo("Downloading file %s\n", file)

	var path bytes.Buffer
	path.WriteString(dest)
	path.WriteString("/")
	path.WriteString(file)

	start := time.Now()

	out, err := os.Create(path.String())

	if err != nil {
		log.LogInfo(path.String())
		log.LogFatal(err)
	}

	defer out.Close()

	headResp, err := http.Head(url)

	log.LogFatal(err)

	defer headResp.Body.Close()

	size, err := strconv.Atoi(headResp.Header.Get("Content-Length"))

	log.LogFatal(err)

	done := make(chan int64)

	go PrintDownloadPercent(done, path.String(), int64(size))

	resp, err := http.Get(url)

	log.LogFatal(err)

	defer resp.Body.Close()

	n, err := io.Copy(out, resp.Body)

	log.LogFatal(err)

	done <- n

	elapsed := time.Since(start)
	log.LogInfo("Download completed in %s", elapsed)
}
