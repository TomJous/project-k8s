# The fleetman project

The fleetman project is a multiservices application that allows tracking and simulating path for trucks in a delivery company. 
It mainly works on Java + Springboot stack and database is a mongodb one. there's also a web app that is written in react.

It is build with six diffferent services that are the following :
 - Web-app
 - Position tracker
 - Positiion simulator
 - Appache active MQ
 - API-Gateway 
 - MongoDB


## Recomendations and requirement

You'll need docker-desktop and docker-engine. If you don't actualy have it on your machina, you can download this on the following url : https://www.docker.com.

Once on docker-desktop, you can then activate kubernetes inside the parameters > kubernetes > enable kubernetes (ensure that you're running kubernetes 1.24 or more)

You'll also need Kubectl install on your device, if you don't have either on your device, follow the instruction on the official instalation page : https://kubernetes.io/docs/tasks/tools/

Last but no least, you'll also need Helm chart on your device. You can find all the instruction to download it on the official page : https://helm.sh/docs/intro/install/

Now you're ready to install the application following the next steps.

## How to install

As there is a lot of folders to actualy update, we created a litle bash script to update them all in once. you can still go in each folder and run the helm depedency update command but we stronghly recommand using the following script with the following command : 

```bash

#In . 
chmod +x allDependenciesUpdate.sh
./allDependencies.Update.sh

```

Now that all libs are update, we can create the final manifest and run it by executing the folliwing commands : 

```bash
# In ./helm/ChartAll

helm update dependency 
helm template . > manifest.yaml
kubectl apply -f manifest.yaml
```

### Congratz, your application works properly ! 


# Technical choice explanation 

- First of all of our choice has been to make a statefull instance of the database inside our cluster even thought it supposed to be stateless because we hadn't the skill to update images so it would have feet our wanting (which was to connect this cluster to a distributed database)

- Secondly we decided for more readability to implement an architecture by folders having the same meaning as the application, which means one micro-service = one folder with the same name. 

- Third choice of us was to create and use a custom lib chart from helm. The aim is to respect the d'ont repeat yourself concept and gain in maintanability while only one file has to be update to in fact update six (for example we have a deployment helper that is suppose to generate all the six deployment's manifest witht eh same base architecture and hydrated via the different values files).

## Chart architecture

Position tracker : Spring Boot app which consume positions from fleetman-queue to store them in fleetman-mongodb
Positiion simulator : Spring Boot app send continous fictives positions trucks
Appache active MQ : an Apache ActiveMQ queue  wich receive and transmit those positions
API-Gateway : starting point of the web-app
    

For every Chart we have the following configuration:
-Chart.lock : declare the inclusion of other charts 
-charts/ : contain the binaries of the included libs 
-Chart.yaml : declare the chart and is dependencies
-values.yaml : set the independent values of the chart
-templates/: contain the template needed for the App imported from libfleetman  


As you can see some templates have also additionnal files 
 For fleetman-api-gateway:
    -persistentVolumeClaim.yaml : declare the access and ressources needed for a request 

For fleetman-mongodb and fleetman-position-tracker
    -persistentVolume.yaml : declare where and how the data will be stored 

The library contains _helpers.tpl and every template, so that the chart can pick only the ones he need.


```bash
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
│   │   ├── Chart.yaml
│   │   ├── templates
│   │   │   ├── deployment.yaml
│   │   │   ├── _helpers.tpl
│   │   │   ├── persistentVolumeClaim.yaml
│   │   │   └── service.yaml
│   │   └── values.yaml
│   ├── fleetman-mongodb
│   │   ├── Chart.lock
│   │   ├── charts
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
```