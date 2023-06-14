#!/bin/bash
# Naam script = opzet_wp.sh

# Ophalen van configuratiebestand klantgegevens_coureur_local.sh
source klantgegevens_coureur_local.sh

# Downloaden en uitpakken van WordPress met Pipe Viewer
curl -# -L "https://wordpress.org/latest.tar.gz" | pv -p -t -e -b -a | tar -xzf - >/dev/null

echo "WordPress is geïnstalleerd."
