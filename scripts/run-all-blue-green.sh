#!/bin/sh

. choice-blue-green

while true; do
  echo "Do you want to initialize the data volume? (y/n) [n]:"
  read -r choice

  choice=${choice:-"n"}
  choice_lowercase=$(echo "$choice" | tr '[:upper:]' '[:lower:]')

  if [ "$choice_lowercase" = "y" ]; then
    while true; do
      echo "Do you really want to initialize? \nUnable to recover after initialization. (y/n) [n]:"
      read -r choice2

      choice2=${choice2:-"n"}
      choice_lowercase2=$(echo "$choice2" | tr '[:upper:]' '[:lower:]')

      if [ "$choice_lowercase2" = "y" ]; then
        echo "Initialize and run the data volume."
        helm upgrade --atomic --install -n local aergoscan-es-$deploymentType ../elasticsearch --set-string deployment.initContainers.initData.enable=true --set-string deployment.type=$deploymentType
        break
      elif [ "$choice_lowercase2" = "n" ]; then
        echo "Keep and run the data volume."
        helm upgrade --atomic --install -n local aergoscan-es-$deploymentType ../elasticsearch --set-string deployment.type=$deploymentType
        break
      else
        echo "Invalid choice. Please enter 'y' or 'n'."
      fi
    done
    break
  elif [ "$choice_lowercase" = "n" ]; then
    echo "Keep and run the data volume."
    helm upgrade --atomic --install -n local aergoscan-es-$deploymentType ../elasticsearch --set-string deployment.type=$deploymentType
    break
  else
    echo "Invalid choice. Please enter 'y' or 'n'."
  fi
done

helm upgrade --atomic --install -n local aergoscan-indexer-$deploymentType ../indexer --set-string deployment.type=$deploymentType
helm upgrade --atomic --install -n local aergoscan-api-$deploymentType ../api --set-string deployment.type=$deploymentType
helm upgrade --atomic --install -n local aergoscan-front-$deploymentType ../front --set-string deployment.type=$deploymentType
