{{- define "libfleetman.PersistentVolume.tpl" -}}
{{- if .Values.persistentVolume.enabled }}
apiVersion: v1
kind: PersistentVolume
metadata:
  name: {{ .Chart.Name }}
spec:
  volumeMode: Filesystem
  accessModes: 
    - ReadWriteMany
  capacity :
    storage: {{ .Values.persistentVolume.size }}
  persistentVolumeReclaimPolicy: Retain
  storageClassName: hostpath
  hostPath:
      path: "/mnt/data"
{{- end }}
{{- end -}}