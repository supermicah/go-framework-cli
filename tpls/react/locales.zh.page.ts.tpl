{{- $name := .Name}}
{{- $lowerCamelName := lowerCamel .Name}}
{{- $parentName := .Extra.ParentName}}
{{- $chineseName := .Extra.ChineseName}}
export default {
    'pages.{{with $parentName}}{{.}}.{{end}}{{$lowerCamelName}}.add': '增加{{$chineseName}}',
    'pages.{{with $parentName}}{{.}}.{{end}}{{$lowerCamelName}}.edit': '编辑{{$chineseName}}',
    'pages.{{with $parentName}}{{.}}.{{end}}{{$lowerCamelName}}.delTip': '确定需要删除?',
    {{- range .Fields}}
    'pages.{{with $parentName}}{{.}}.{{end}}{{$lowerCamelName}}.form.{{lowerUnderline .Name}}': '{{.Extra.ChineseName}}',
    'pages.{{with $parentName}}{{.}}.{{end}}{{$lowerCamelName}}.form.{{lowerUnderline .Name}}.placeholder': '请输入{{.Extra.ChineseName}}',
    'pages.{{with $parentName}}{{.}}.{{end}}{{$lowerCamelName}}.form.{{lowerUnderline .Name}}.required': '{{.Extra.ChineseName}}是必填项!',
    {{- end}}
};
