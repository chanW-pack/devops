{{- define "db-proc-firing" -}}
-- *{{ .Annotations.summary }}.* --
  ❗ 대상 : *{{ .Labels.name }}* of *{{ .Labels.alias }}* 
  ⌛ 시간 : {{ .StartsAt }}
  ⛳ URL : {{ .Annotations.URL }}
  {{ "\n" }}
{{ end }}

{{- define "db-proc-resolved" -}}
-- *{{ .Annotations.summary }}.* --
  ✅ 대상 : *{{ .Labels.name }}* of *{{ .Labels.alias }}* 
  ⌛ 시간 : {{ .StartsAt }}
  ⛳ URL : {{ .Annotations.URL }}
  {{ "\n" }}
{{ end }}

{{ define "db-proc-alert" }}
  {{ $firingCount := len .Alerts.Firing }}
  {{ $resolvedCount := len .Alerts.Resolved }}

  {{ if gt $firingCount 0 }}
    🔥🔥 [Alert] *경고 {{ $firingCount }}개 발생* 🔥🔥
    {{ range .Alerts.Firing -}} {{- template "db-proc-firing" . }} 
	{{ end }}
  {{ end }}

  {{ if gt $resolvedCount 0 }}
    🌊🌊 [OK] *경고 {{ $resolvedCount }}개 안정화* 🌊🌊 
    {{ range .Alerts.Resolved -}} {{- template "db-proc-resolved" . }}
	 {{ end }}
  {{ end }}
{{ end }}
