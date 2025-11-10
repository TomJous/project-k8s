{{- define "libfleetman.deployment.tpl" -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Chart.Name }}
  namespace: {{ .Values.namespace }}
  labels:
    app: {{ .Chart.Name }}
spec:
  replicas: {{ .Values.deployment.replicas }}
  selector:
    matchLabels:
      app: {{ .Chart.Name }}
  template:
    metadata:
      labels:
        app: {{ .Chart.Name }}
    spec:
      containers:
        - name: {{ .Chart.Name }}
          image: {{ .Values.deployment.container.image }}         
          ports:
          {{- range .Values.deployment.ports }}
          - containerPort: {{ .containerPort }}
          {{- end }}
          {{- if .Values.deployment.env.enabled }}
          env:
            - name: {{ .Values.deployment.env.name }}
              value: {{ .Values.deployment.env.value }}
          {{- end }}
          {{- if .Values.deployment.volumeMount.enabled }}
          volumeMounts:
            - name: {{ .Values.deployment.volumeMount.name }}
              mountPath: {{ .Values.deployment.volumeMount.mountPath }}
          {{- end }}
          
          {{- $ressources := default dict .Values.deployment.ressources }}

          {{- if $ressources.enabled }}
          resources:
            requests:
              memory: {{ .Values.deployment.ressources.requests.memory | quote }}
              cpu: {{ .Values.deployment.ressources.requests.cpu | quote }}
            limits:
              memory: {{ .Values.deployment.ressources.limits.memory | quote }}
              cpu: {{ .Values.deployment.ressources.limits.cpu | quote}}
          {{- end }}
      {{- if .Values.deployment.volume.enabled }}
      volumes:
        - name: {{ .Values.deployment.volume.name }}
          persistentVolumeClaim:
            claimName: {{ .Chart.Name }}
      {{- end }}
{{- end -}}