package misc

// func red(msg string) string {
// 	return "\033[0;31m" + msg + "\033[0m"
// }

func Blue(msg string) string {
	return "\033[0;34m" + msg + "\033[0m"
}

func Redbold(msg string) string {
	return "\033[1;31m" + msg + "\033[0m"
}
