{{$includeStatus := .Include.Status}}
declare namespace API {
  {{with .Comment}}// {{.}}{{end}}
  type {{.Name}} = {
    {{- range .Fields}}{{$fieldName := .Name}}
    {{- with .Comment}}
    /** {{.}} */
    {{- end}}
	  {{lowerUnderline $fieldName}}?: {{convGoTypeToJSType .Type}};
	  {{- end}}
    {{- if $includeStatus}}
    statusChecked?: boolean;
    {{- end}}
  };
}