{{- define "exploit-iq-models.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}

{{- end }}

{{- define "exploit-iq-models.logic_check" -}}
{{- if and .Values.llama3_1_70b_instruct_4bit.enabled .Values.nim_llm.enabled }}
  hello: {{- required "Only one of models should be deployed!, either llama3_1_70b_instruct_4bit or nim_llm 8b, but not both!" .Values.whatever -}}
{{- end }}
{{- end }}



{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "exploit-iq-models.fullname" -}}
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
{{- define "exploit-iq-models.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "exploit-iq-models.labels" -}}
helm.sh/chart: {{ include "exploit-iq-models.chart" . }}
{{ include "exploit-iq-models.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app: exploit-iq
component: all-models
{{- end }}

{{/*
Selector labels
*/}}
{{- define "exploit-iq-models.selectorLabels" -}}
app.kubernetes.io/name: {{ include "exploit-iq-models.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "exploit-iq-models.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "exploit-iq-models.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
