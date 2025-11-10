# The fleetman project

The fleetman project is a multiservices application that allows tracking and simulating path for trucks in a delivery company. 
It mainly works on Java + Springboot stack and database is a mongodb one. there's also a web app that is written in react.

It is build with six diffferent services that are the following :
 - Web-app
 - Position tracker
 - Positiion simulator
 - RabbitMQ
 - API-Gateway 
 - MongoDB

## Recomendations and requirement

You'll need docker-desktop and docker-engine, you can download this on the following url : https://www.docker.com.
Once on docker-desktop, you can activate the kubernetes 



```bash
# In ./helm/ChartAll

helm update dependency 
helm template . > manifest.yaml
kubectl apply -f manifest.yaml
```




## Chart architecture

├── allDependenciesUpdate.sh
├── helm
│   ├── ChartAll
│   │   ├── Chart.lock
│   │   ├── charts
│   │   ├── Chart.yaml
│   │   └── manifest.yaml
│   ├── fleetman-api-gateway
│   │   ├── Chart.lock
│   │   ├── charts
│   │   │   └── libfleetman-0.1.0.tgz
│   │   ├── Chart.yaml
│   │   ├── manifest.yaml
│   │   ├── templates
│   │   │   ├── deployment.yaml
│   │   │   ├── _helpers.tpl
│   │   │   ├── persistentVolumeClaim.yaml
│   │   │   └── service.yaml
│   │   └── values.yaml
│   ├── fleetman-mongodb
│   │   ├── Chart.lock
│   │   ├── charts
│   │   │   └── libfleetman-0.1.0.tgz
│   │   ├── Chart.yaml
│   │   ├── manifest.yaml
│   │   ├── templates
│   │   │   ├── deployment.yaml
│   │   │   ├── persistentVolume.yaml
│   │   │   └── service.yaml
│   │   └── values.yaml
│   ├── fleetman-position-simulator
│   │   ├── Chart.lock
│   │   ├── charts
│   │   ├── Chart.yaml
│   │   ├── templates
│   │   │   ├── deployment.yaml
│   │   │   └── service.yaml
│   │   └── values.yaml
│   ├── fleetman-position-tracker
│   │   ├── Chart.lock
│   │   ├── charts
│   │   ├── Chart.yaml
│   │   ├── templates
│   │   │   ├── deployment.yaml
│   │   │   ├── persistentVolume.yaml
│   │   │   └── service.yaml
│   │   └── values.yaml
│   ├── fleetman-queue
│   │   ├── Chart.lock
│   │   ├── charts
│   │   ├── Chart.yaml
│   │   ├── templates
│   │   │   ├── deployment.yaml
│   │   │   └── service.yaml
│   │   └── values.yaml
│   ├── fleetman-webapp
│   │   ├── Chart.lock
│   │   ├── charts
│   │   ├── Chart.yaml
│   │   ├── templates
│   │   │   ├── deployment.yaml
│   │   │   └── service.yaml
│   │   └── values.yaml
│   ├── libfleetman
│   │   ├── Chart.yaml
│   │   └── templates
│   │       ├── _deployment.tpl
│   │       ├── _helpers.tpl
│   │       ├── _namespace.tpl
│   │       ├── _persistentvolumeclaim.tpl
│   │       ├── _persistentvolume.tpl
│   │       └── _service.tpl
│   └── namespace
│       ├── Chart.lock
│       ├── charts
│       ├── Chart.yaml
│       ├── templates
│       │   └── namespace.yaml
│       └── values.yaml