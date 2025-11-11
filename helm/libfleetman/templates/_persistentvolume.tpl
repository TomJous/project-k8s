{{- define "libfleetman.PersistentVolume.tpl" -}}
{{- if .Values.persistentVolume.enabled }}
apiVersion: v1
kind: PersistentVolume
metadata:
  name: {{ .Chart.Name }}
spec:
  volumeMode: Filesystem
  accessModes: 
    - {{ .Values.persistentVolume.accessModes }}
  capacity :
    storage: {{ .Values.persistentVolume.size }}
  persistentVolumeReclaimPolicy: {{ .Values.persistentVolume.persistentVolumeReclaimPolicy }}
  storageClassName: {{ .Values.persistentVolume.storageClassName }}
  hostPath:
      path: {{ .Values.persistentVolume.path | quote }}
{{- end }}
{{- end -}}