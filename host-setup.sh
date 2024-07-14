#!/bin/bash

# Check if the entry already exists
if ! grep -q "rseelaen.42.fr" /etc/hosts; then
  # Append the entry to the hosts file
  # echo "127.0.0.1    rseelaen.42.fr" | sudo -S tee -a /etc/hosts <<< "user42" > /dev/null
  echo user42 | sudo -S sleep 1 && sudo sed -i '/localhost/s/$/ rseelaen.42.fr/' /etc/hosts
  echo "Hosts file updated."
else
  echo "Entry already exists."
fi