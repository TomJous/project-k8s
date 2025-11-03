{{- define "libfleetman.deployment.tpl" -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Release.Name | printf "%s-%s" .Chart.Name }}
  namespace: {{ .Chart.Name }}
  labels:
    app: {{ .Release.Name | printf "%s-%s" .Chart.Name }}
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
          
          # Définition de mes dict pour éviter accès à la nil (éviter les erreurs)
          {{- $ports := default dict .Values.deployment.ports }}
          {{- $targetPort := default dict $ports.targetPort }}
          {{- $containerPort := default dict $ports.containerPort }}

          {{- if or (eq $targetPort.enabled true) (eq $containerPort.enabled true) }}
          ports:
          
          {{- if  $targetPort.enabled }}
          - targetPort: {{ $targetPort.value }}
          {{- end }}

          {{- if $containerPort.enabled }}
          - containerPort: {{ $containerPort.value }}
          {{- end }}

          {{- end }}

          {{- if .Values.deployment.env.enabled }}
          env:
            - name: {{ .Values.deployment.env.name }}
              value: {{ .Values.deployment.env.value }}
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
{{- end -}}