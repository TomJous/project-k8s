{{- define "libfleetman.namespace.tpl" -}}
apiVersion: v1
kind: Namespace
metadata:
  name: {{ .Values.namespace }}
{{- end -}}