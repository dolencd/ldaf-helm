{{/*
Expand the name of the chart.
*/}}
{{- define "ldaf.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ldaf.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ldaf.chart" -}}
{{- printf "%s-%s" $.Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "ldaf.redissvc" -}}
{{- printf "%s-redis-master" .Release.Name | quote }}
{{- end }}

{{- define "ldaf.rabbitmq" -}}
{{- printf "amqp://%s-rabbitmq" .Release.Name | quote }}
{{- end }}


{{/*
Common labels
*/}}
{{- define "ldaf.labels" -}}
helm.sh/chart: {{ include "ldaf.chart" . }}
{{ include "ldaf.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ldaf.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ldaf.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "ldaf.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "ldaf.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
