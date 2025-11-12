#!/bin/bash

# Script to update dependencies for all Helm charts
# Give execution permissions: chmod +x allDependenciesUpdate.sh
# Run it this way: ./allDependenciesUpdate.sh
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# The script path
echo "Script directory : $SCRIPT_DIR" 

# For each Chart in the directory helm, we update the dependencies of each one
for d in $SCRIPT_DIR/helm/*/; do
  if [ -f "$d/Chart.yaml" ]; then
    echo "Updating dependencies in $d"
    helm dependency update "$d"
  fi
done

# Update the ChartAll to take all the changes
echo "Updating dependencies in $SCRIPT_DIR/helm/ChartAll"
helm dependency update "$SCRIPT_DIR/helm/ChartAll"