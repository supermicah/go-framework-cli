package main

import (
	"embed"
	"os"

	"github.com/supermicah/go-framework-cli/cmd"
	"github.com/supermicah/go-framework-cli/internal/tfs"
	"github.com/urfave/cli/v2"
	"go.uber.org/zap"
)

// f 允许项目打包时附带非go相关的文件
//
//go:embed tpls
var f embed.FS

var VERSION = "v1.0.0"

func main() {
	// 刷新日志，当程序退出时，把在缓存中的内容刷到日志中
	defer func() {
		_ = zap.S().Sync()
	}()

	logger, err := zap.NewDevelopmentConfig().Build(zap.WithCaller(false))
	if err != nil {
		panic(err)
	}
	zap.ReplaceGlobals(logger)

	// Set the embed.FS to the fs package
	tfs.SetEFS(f)

	app := cli.NewApp()
	app.Name = "go-go-framework-cli"
	app.Version = VERSION
	app.Usage = "A command line tool for Go framework."
	app.Authors = append(app.Authors, &cli.Author{
		Name:  "micah",
		Email: "micah.shi@gmail.com",
	})
	app.Commands = []*cli.Command{
		cmd.Version(VERSION),
		cmd.New(),
		cmd.Generate(),
		cmd.Remove(),
	}

	if err := app.Run(os.Args); err != nil {
		panic(err)
	}
}
