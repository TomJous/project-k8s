#!/bin/bash

# Script pour mettre à jourd les dépendances de tous les charts Helm
# Donner les permissions d'exécutions : chmod +x allDependenciesUpdate.sh
# L'exécuter de cette façon : ./allDependenciesUpdate.sh
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Le chemin du script
echo "Script directory : $SCRIPT_DIR" 

# Parcourir chaque Chart dans le dossier helm
for d in $SCRIPT_DIR/helm/*/; do
  if [ -f "$d/Chart.yaml" ]; then
    echo "Updating dependencies in $d"
    helm dependency update "$d"
  fi
done

# Mettre à jour le ChartAll à la fin pour avoir toutes les mises à jours
echo "Updating dependencies in $SCRIPT_DIR/helm/ChartAll"
helm dependency update "$SCRIPT_DIR/helm/ChartAll"