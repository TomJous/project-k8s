#!/bin/bash

# Script pour mettre à jourd les dépendances de tous les charts Helm
# Donner les permissions d'exécutions : chmod +x allDependenciesUpdate.sh
# L'exécuter de cette façon : ./allDependenciesUpdate.sh

for d in helm/*/; do
  if [ -f "$d/Chart.yaml" ]; then
    echo "Updating dependencies in $d"
    helm dependency update "$d"
  fi
done
