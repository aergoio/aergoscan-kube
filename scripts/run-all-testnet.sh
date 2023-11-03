#!/bin/sh
while true; do
  echo "Do you want to initialize the data volume? (y/n) [n]:"
  read -r choice

  choice=${choice:-"n"}
  choice_lowercase=$(echo "$choice" | tr '[:upper:]' '[:lower:]')

  if [ "$choice_lowercase" = "y" ]; then
    while true; do
      echo "Do you really want to initialize?\nUnable to recover after initialization. (y/n) [n]:"
      read -r choice2

      choice2=${choice2:-"n"}
      choice_lowercase2=$(echo "$choice2" | tr '[:upper:]' '[:lower:]')

      if [ "$choice_lowercase2" = "y" ]; then
        echo "Initialize and run the data volume."
        helm upgrade --atomic --install aergoscan-es ../elasticsearch -f ~/aergoscan-kube/elasticsearch/values-testnet.yaml --set-string deployment.initContainers.initData.enable=true
        break
      elif [ "$choice_lowercase2" = "n" ]; then
        echo "Keep and run the data volume."
        helm upgrade --atomic --install aergoscan-es ../elasticsearch -f ~/aergoscan-kube/elasticsearch/values-testnet.yaml
        break
      else
        echo "Invalid choice. Please enter 'y' or 'n'."
      fi
    done
    break
  elif [ "$choice_lowercase" = "n" ]; then
    echo "Keep and run the data volume."
    helm upgrade --atomic --install aergoscan-es ../elasticsearch -f ~/aergoscan-kube/elasticsearch/values-testnet.yaml
    break
  else
    echo "Invalid choice. Please enter 'y' or 'n'."
  fi
done

helm upgrade --atomic --install aergoscan-indexer ../indexer -f ~/aergoscan-kube/indexer/values-testnet.yaml
helm upgrade --atomic --install aergoscan-api ../api -f ~/aergoscan-kube/api/values-testnet.yaml
helm upgrade --atomic --install aergoscan-front ../front -f ~/aergoscan-kube/front/values-testnet.yaml