{{- define "libfleetman.persistentVolumeClaim.tpl" -}}
{{- if .Values.persistentVolumeClaim.enabled }}
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{ .Release.Name | printf "%s-%s" .Chart.Name }}
  namespace: {{ .Values.namespace }}
spec:
  accessModes:
    - {{ .Values.persistentVolumeClaim.accessModes }}
  storageClassName: {{ .Values.persistentVolumeClaim.storageClassName }}
  resources:
    requests:
      storage: {{ .Values.persistentVolumeClaim.storage }}
{{- end }}
{{- end -}}