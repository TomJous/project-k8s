# The fleetman project

The fleetman project is a multiservices application that allows tracking and simulating path for trucks in a delivery company. 
It mainly works on Java + Springboot stack and database is a mongodb one. there's also a web app that is written in react.

It is build with six different services that are the following :
 - Web-app
 - Position tracker
 - Position simulator
 - Apache active MQ
 - API-Gateway 
 - MongoDB


## Recommendations and requirement

You'll need docker-desktop and docker-engine. If you don't actually have it on your machine, you can download this on the following url : https://www.docker.com.

Once on docker-desktop, you can then activate kubernetes inside the parameters > kubernetes > enable kubernetes (ensure that you're running kubernetes 1.24 or more)

You'll also need Kubectl install on your device, if you don't have either on your device, follow the instruction on the official installation page : https://kubernetes.io/docs/tasks/tools/

Last but not least, you'll also need Helm chart on your device. You can find all the instruction to download it on the official page : https://helm.sh/docs/intro/install/

Now you're ready to install the application following the next steps.

## How to install

As there is a lot of folders to actualy update, we created a litle bash script to update them all in once. you can still go in each folder and run the helm depedency update command but we stronghly recommand using the following script with the following command : 

```bash

#In . 
chmod +x allDependenciesUpdate.sh
./allDependenciesUpdate.sh

```

Now that all libs are update, we can create the final manifest and run it by executing the following commands : 

```bash
# In ./helm/ChartAll

helm dependency update
helm template . > manifest.yaml
kubectl apply -f manifest.yaml
```

## Adapt the chart as you need

Helm Chart is a template engine used to create Kubernetes manifests. The values can be modified according to your infrastructure requirements using the argument '--set key=value' (which will override the actual values.yaml file) or by updating the values.yaml file inside the different folders.  

here is a list of the properties you can update inside all of the values.yaml files or with the override command :

### Deployment

- deployment : all inside this property is made to generate the deployment part of the manifest.

- deployment.replicas : set the number of replicas for this deployment.

- deployment.container.image : define the container image used for this deployment.

- deployment.env.enabled : enable or disable the environment variable for the container.
 
- deployment.env.name : define the name of the environment variable.

- deployment.env.value : define the value of the environment variable.

- deployment.ressources.enabled : enable or disable the resource configuration.

- deployment.ressources.requests.memory : define the minimum memory requested by the container.

- deployment.ressources.requests.cpu : define the minimum CPU requested by the container.

- deployment.ressources.limits.memory : define the maximum memory the container can use.

- deployment.ressources.limits.cpu : define the maximum CPU the container can use.

- deployment.ports : define as much ports properties as you need for your Deployment.

- deployment.ports.first-port.containerPort : define the port exposed by the container.

- deployment.volumeMount.enabled : enable or disable the volume mount.

- deployment.volumeMount.name : define the name of the volume to mount.

- deployment.volumeMount.mountPath : define the path inside the container where the volume will be mounted.

- deployment.volume.enabled : enable or disable the volume declaration.

- deployment.volume.name : define the name of the volume used by the pod.

### Service

- service : all inside this property is made to generate the service part of the manifest.

- service.ports : define as much ports properties as you need for your Service.

- service.ports.first-port.name : define the name of the service port.

- service.ports.first-port.port : define the external service port.

- service.ports.first-port.targetPort : define the target port inside the container.

- service.type : define the type of service you want (leave empty or set as default = ClusterIP). If the type is equal to NodePort, then the targetPort will take the value of service.ports.first-port.port and nodePort will take the service.ports.first-port.targetPort value.

### Namespace

- namespace : define the namespace where all resources will be deployed.

### Persistent Volume

- persistentVolume : all inside this property is made to generate the PersistentVolume resource.

- persistentVolume.enabled : enable or disable the creation of the PV.

- persistentVolume.size : define the size of the volume.

- persistentVolume.accessModes : define how the volume can be accessed (e.g., ReadWriteOnce).

- persistentVolume.storageClassName : define the storage class used by the PV.

- persistentVolume.persistentVolumeReclaimPolicy : define the reclaim policy after the volume is released.

- persistentVolume.path : define the storage path on the node.

### Persistent Volume Claim

- persistentVolumeClaim : all inside this property is made to generate the PersistentVolumeClaim resource.

- persistentVolumeClaim.enabled : enable or disable the creation of the PVC.

- persistentVolumeClaim.size : define the size of the claimed volume.

- persistentVolumeClaim.accessModes : define how the PVC can access the volume.

- persistentVolumeClaim.storageClassName : define the storage class used for the PVC.


# Technical choice explanation 

- First of all our choice has been to make a stateful instance of the database inside our cluster even though it is supposed to be stateless because we hadn't the skill to update images so it would have fit our wanting (which was to connect this cluster to a distributed database)

- Secondly we decided for more readability to implement an architecture by folders having the same meaning as the application, which means one micro-service = one folder with the same name. This allows you to test one by one and more easily manage values for deployment and service. 

- Third choice of us was to create and use a custom lib chart from helm. The aim is to respect the don't repeat yourself concept and gain in maintainability, since updating a single file allows us to update all six deployments at once (for example, we have a deployment helper that generates all six deployment manifests with the same base architecture, hydrated via the different values files).

- Finaly and because of the low resources we had on our device, we decidede to apply gpu limits and only one replica for every single micro service but feel free to upgrade this as your good will. 

## Chart architecture

Position tracker : Spring Boot app which consume positions from fleetman-queue to store them in fleetman-mongodb
Position simulator : Spring Boot app sends continuous fictitious truck positions
Appache active MQ : an Apache ActiveMQ queue  which receive and transmit those positions
API-Gateway : starting point of the web-app
    

For every Chart we have the following configuration:
-Chart.lock : declare the inclusion of other charts 
-charts/ : contain the binaries of the included libs 
-Chart.yaml : declare the chart and is dependencies
-values.yaml : set the independent values of the chart
-templates/: contain the template needed for the App imported from libfleetman  


As you can see the fleetman-mongodb have additionnal files :
    -persistentVolumeClaim.yaml : declare the access and resources needed for a request 
    -persistentVolume.yaml : declare where and how the data will be stored 

The library contains every helpers that we use in other folders written as helpers inside the template directory, so that the chart can pick only the ones it needs.

a   q
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
│   │   │   ├── persistentVolumeClaim.yaml
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



this project has been made by Quentin Mialon, Julien Renoult and Tom Jousset