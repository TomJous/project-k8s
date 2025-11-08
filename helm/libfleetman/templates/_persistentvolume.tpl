{{- define "libfleetman.PersistentVolume.tpl" -}}
{{- if .Values.persistentVolume.enabled }}
apiVersion: v1
kind: PersistentVolume
metadata:
  name: {{ .Release.Name | printf "%s-%s" .Chart.Name }}
spec:
  accessModes: 
    - readWriteMany
  ressources:
    requests:
      storage: {{ .Values.persistentVolume.size }}
  storageClassName: standard
{{- end }}
{{- end -}}