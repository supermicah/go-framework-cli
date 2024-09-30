package tfs

import (
	"embed"
	"path/filepath"
	"runtime"
	"strings"
)

var efsIns embed.FS

func SetEFS(fs embed.FS) {
	efsIns = fs
}

func EFS() embed.FS {
	return efsIns
}

type embedFS struct {
}

func NewEmbedFS() FS {
	return &embedFS{}
}

func (fs *embedFS) ReadFile(name string) ([]byte, error) {
	fullName := filepath.Join("tpls", name)
	if runtime.GOOS == "windows" {
		fullName = strings.ReplaceAll(fullName, "\\", "/")
	}
	return efsIns.ReadFile(fullName)
}

func (fs *embedFS) ParseTpl(name string, data interface{}) ([]byte, error) {
	tplBytes, err := fs.ReadFile(name)
	if err != nil {
		return nil, err
	}
	return parseTplData(string(tplBytes), data)
}
