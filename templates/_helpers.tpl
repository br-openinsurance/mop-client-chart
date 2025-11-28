{{/*
Retorna o nome do Chart
*/}}
{{- define "mop-client.name" -}}
{{ .Chart.Name }}
{{- end }}


{{/*
Nome completo do release + chart
Exemplo: mop-prod-mop-client
*/}}
{{- define "mop-client.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end }}


{{/*
Labels padrão recomendados pela CNCF
Usados em todos os objetos
*/}}
{{- define "mop-client.labels" -}}
helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
app.kubernetes.io/name: {{ include "mop-client.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}


{{/*
Labels usados em selectors
Sempre estáveis e não mudam durante upgrades
*/}}
{{- define "mop-client.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mop-client.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{/*
Resolve a imagem completa:
<registry>/<repo>:<tag>
*/}}
{{- define "mop-client.image" -}}
{{- printf "%s/%s:%s" .Values.global.imageRegistry .image.repository .image.tag -}}
{{- end }}


{{/*
Resolve dinamicamente o namespace da aplicação
Se NÃO houver namespace definido → usa o namespace do release
*/}}
{{- define "mop-client.appNamespace" -}}
{{- if .namespace }}
{{ .namespace }}
{{- else }}
{{ .Release.Namespace }}
{{- end }}
{{- end }}


{{/*
Retorna o nome do ServiceAccount caso você venha a criar futuramente
*/}}
{{- define "mop-client.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{ include "mop-client.fullname" . }}
{{- else }}
default
{{- end }}
{{- end }}
