{{- define "libfleetman.PersistentVolume.tpl" -}}
{{- if .Values.persistentVolume.enabled }}
apiVersion: v1
kind: PersistentVolume
metadata:
  name: {{ .Release.Name | printf "%s-%s" .Chart.Name }}
spec:
  capacity:
    storage: {{ .Values.persistentVolume.storage }}
  volumeMode: {{ .Values.persistentVolume.volumeMode }}
  accessModes:
    - {{ .Values.persistentVolume.accessModes }}
  persistentVolumeReclaimPolicy: {{ .Values.persistentVolume.persistentVolumeReclaimPolicy }}
  storageClassName: {{ .Values.persistentVolume.storageClassName }}
  mountOptions:
    - hard
    - nfsvers=4.1
  nfs:
    path: /tmp
    server: 172.17.0.2
{{- end }}
{{- end -}}