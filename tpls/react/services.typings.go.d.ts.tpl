{{$includeStatus := .Include.Status}}
declare namespace GoAPI {
  {{with .Comment}}// {{.}}{{end}}
  type {{.Name}} = {
    {{- range .Fields}}{{$fieldName := .Name}}
    {{- with .Comment}}
    /** {{.}} */
    {{- end}}
	  {{lowerUnderline $fieldName}}?: {{convGoTypeToTsType .Type}};
	  {{- end}}
    {{- if $includeStatus}}
    statusChecked?: boolean;
    {{- end}}
  };
}