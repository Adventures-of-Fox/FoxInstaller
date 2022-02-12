package misc

import "runtime"

func CheckOS() string {
	switch runtime.GOOS {
	case "windows":
		return "win"
	default:
		return "unix"
	}
}
