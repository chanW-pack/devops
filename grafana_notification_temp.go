{{- define "myalert112" -}}

🔥🔥 [Alert] *{{ .Labels.alertname }}.* 🔥🔥
  `{{ .Labels.grafana_folder }}` {{ .Labels.job }}
  -- To be checked --
  ❗ 호스트 : *{{ .Labels.alias }}* 
  ▫️ 서비스 : *{{ .Labels.name }}*
  {{ .StartsAt }}
  대시보드: *{{ .Annotations.URL }}*

{{ end }}

{{- define "myalert113" -}}

🌊🌊 [OK] *{{ .Labels.alertname }}.* 🌊🌊
  `{{ .Labels.grafana_folder }}` {{ .Labels.job }}
  -- To be checked --
  ✅ 호스트 : *{{ .Labels.alias }}* 
  ▫️ 서비스 : *{{ .Labels.name }}*
  {{ .StartsAt }}
  대시보드: *{{ .Annotations.URL }}*

{{ end }}

{{ define "cwzzang" }}
  {{ if gt (len .Alerts.Firing) 0 }}
    {{ range .Alerts.Firing }} {{ template "myalert112" .}} {{ end }}
  {{ end }}
  {{ if gt (len .Alerts.Resolved) 0 }}
    {{ range .Alerts.Resolved }} {{ template "myalert113" .}} {{ end }}
  {{ end }}
{{ end }}
