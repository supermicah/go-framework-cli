package utils

import (
	"bytes"
	"strings"

	"golang.org/x/text/language"

	"github.com/jinzhu/inflection"
	"golang.org/x/text/cases"
)

var commonInitialismSlice = []string{"API", "ASCII", "CPU", "CSS", "DNS", "EOF", "GUID", "HTML", "HTTP", "HTTPS", "ID", "IP", "JSON", "LHS", "QPS", "RAM", "RHS", "RPC", "SLA", "SMTP", "SSH", "TLS", "TTL", "UID", "UI", "UUID", "URI", "URL", "UTF8", "VM", "XML", "XSRF", "XSS"}
var commonInitialismSliceReplacer *strings.Replacer

func init() {
	var commonInitialismSliceForReplacer []string
	for _, initialism := range commonInitialismSlice {
		//title := strings.Title(strings.ToLower(initialism))
		title := cases.Title(language.English).String(strings.ToLower(initialism))
		commonInitialismSliceForReplacer = append(commonInitialismSliceForReplacer, initialism, title)
	}
	commonInitialismSliceReplacer = strings.NewReplacer(commonInitialismSliceForReplacer...)
}

func ToLowerUnderlinedNamer(name string) string {
	const (
		upper = true
	)

	if name == "" {
		return ""
	}

	var (
		value                                                                = commonInitialismSliceReplacer.Replace(name)
		buf                                                                  = bytes.NewBufferString("")
		lastCaseIsUpper, currCaseIsUpper, nextCaseIsUpper, nextNumberIsUpper bool
	)

	for i, v := range value[:len(value)-1] {
		nextCaseIsUpper = value[i+1] >= 'A' && value[i+1] <= 'Z'
		nextNumberIsUpper = value[i+1] >= '0' && value[i+1] <= '9'

		if i > 0 {
			if currCaseIsUpper {
				if lastCaseIsUpper && (nextCaseIsUpper || nextNumberIsUpper) {
					buf.WriteRune(v)
				} else {
					if value[i-1] != '_' && value[i+1] != '_' {
						buf.WriteRune('_')
					}
					buf.WriteRune(v)
				}
			} else {
				buf.WriteRune(v)
				if i == len(value)-2 && (nextCaseIsUpper && !nextNumberIsUpper) {
					buf.WriteRune('_')
				}
			}
		} else {
			currCaseIsUpper = upper
			buf.WriteRune(v)
		}
		lastCaseIsUpper = currCaseIsUpper
		currCaseIsUpper = nextNumberIsUpper
	}

	buf.WriteByte(value[len(value)-1])

	s := strings.ToLower(buf.String())
	return s
}

func ToPlural(v string) string {
	return inflection.Plural(v)
}

func toLowerPlural(v, sep string) string {
	ss := strings.Split(ToLowerUnderlinedNamer(v), "_")
	if len(ss) > 0 {
		ss[len(ss)-1] = ToPlural(ss[len(ss)-1])
	}
	return strings.Join(ss, sep)
}

func ToLowerPlural(v string) string {
	return toLowerPlural(v, "")
}

func ToLowerSpacePlural(v string) string {
	return toLowerPlural(v, " ")
}

func ToLowerHyphensPlural(v string) string {
	return toLowerPlural(v, "-")
}

func ToLowerCamel(v string) string {
	if v == "" {
		return ""
	}
	return strings.ToLower(v[:1]) + v[1:]
}

func ToLowerSpacedNamer(v string) string {
	return strings.Replace(ToLowerUnderlinedNamer(v), "_", " ", -1)
}

func ToTitleSpaceNamer(v string) string {
	vv := strings.Split(ToLowerUnderlinedNamer(v), "_")
	if len(vv) > 0 && len(vv[0]) > 0 {
		vv[0] = strings.ToUpper(vv[0][:1]) + vv[0][1:]
	}
	return strings.Join(vv, " ")
}
