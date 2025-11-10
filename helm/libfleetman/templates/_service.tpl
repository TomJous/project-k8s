{{- define "libfleetman.service.tpl" -}}
apiVersion: v1
kind: Service
metadata:
  name: {{ .Chart.Name }}
  namespace: {{ .Values.namespace }}
spec:
  selector:
    app: {{ .Chart.Name }}
  ports:  
    {{- range .Values.service.ports }}
    - protocol: {{ default "TCP" $.Values.service.protocol }}
      name: {{ .name }}
      port: {{ .port }}
      targetPort: {{ .targetPort }}
    {{- end }}
  type: {{ default "ClusterIP" .Values.service.type }}
{{- end -}}