{{- define "libfleetman.persistentVolumeClaim.tpl" -}}
{{- if .Values.persistentVolumeClaim.enabled }}
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{ .Chart.Name }}
  labels :
    app: {{ .Chart.Name }}
  namespace: {{ .Values.namespace }}
spec:
  accessModes:
    - {{ .Values.persistentVolumeClaim.accessModes }}
  storageClassName: {{ .Values.persistentVolumeClaim.storageClassName }}
  resources:
    requests:
      storage: {{ .Values.persistentVolumeClaim.size }}
{{- end }}
{{- end -}}