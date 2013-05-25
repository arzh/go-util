package console

import (
	"os"
	"bufio"
	"fmt"
)

var g_reader bufio.Reader

func Init() {
	g_reader = bufio.NewReader(os.Stdin)
}

func Write(s string) {
	fmt.WriteLine(s)
}

func Read() string {
	s, e := g_reader.ReadString("\n")
	if e != nil {
		s = e.Error()
	}
	return s
}

