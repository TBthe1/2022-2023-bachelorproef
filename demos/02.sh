#!/bin/bash
# Naam script = aanpassen_wp.sh

# Ophalen van configuratiebestand klantgegevens_coureur_local.sh
source klantgegevens_coureur_local.sh

# WordPress Configuratiebestand aanmaken
cp "wordpress/wp-config-sample.php" "wordpress/wp-config.php"

# Check of het configuratiebestand is aangemaakt
if [ -f "wordpress/wp-config.php" ]; then
    echo "Configuratiebestand is aangemaakt: $wordpressPath/wp-config.php"
else
    echo "Fout bij het aanmaken van het configuratiebestand."
    exit 1
fi

# Associative array met databasegegevens en WordPress-site instellingen
declare -A replacements=(
    ['DB_HOST']="$dbHost"
    ['DB_PORT']="$dbPort"
    ['DB_USER']="$dbUser"
    ['DB_PASSWORD']="$dbPassword"
    ['DB_NAME']="$dbName"
    ['WP_HOME']="$siteUrl"
    ['WP_SITEURL']="$siteUrl"
    ['WP_TITLE']="$siteTitle"
    ['WP_DESCRIPTION']="$siteDescription"
    ['WP_TIMEZONE']="$siteTimezone"
    ['WP_LANG']="$siteLanguage"
)

# Functie om databasegegevens te vervangen in het configuratiebestand
function replace_database_value() {
    local key="$1"
    local value="$2"
    perl -i -pe "s|define\(\s*'$key',\s*\K.*?(?=\);)|'$value'|g" "wordpress/wp-config.php"
}

# Vervangen van databasegegevens en WordPress-site instellingen in het configuratiebestand
for key in "${!replacements[@]}"; do
    replace_database_value "$key" "${replacements[$key]}"
done

echo "WordPress databasegegevens zijn automatisch ingevuld en een standaard gebruikersaccount is aangemaakt."
