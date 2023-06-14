#!/bin/bash
# Naam script = custom_theme_wp.sh

# Ophalen van configuratiebestand klantgegevens_coureur_local.sh
source klantgegevens_coureur_local.sh

# Navigate to the themes directory
cd "wordpress/wp-content/themes/"

# Create the custom theme folder
mkdir -p "$themeName"

# Navigate back to root
cd "../../../"

currentDirectory=$(pwd)

# Add a theme image to the theme folder
sampleImage="$currentDirectory/../assets/coureurlocalrond150.png"
destinationImagePath="$currentDirectory/$themesPath/$themeName/styles.png"
cp "$sampleImage" "$destinationImagePath"

# Create the necessary theme files
styleFilePath="$currentDirectory/$themesPath/$themeName/style.css"
indexFilePath="$currentDirectory/$themesPath/$themeName/index.php"

# Generate the content for the style.css file
styleContent="/*
Theme Name: $themeName
Description: $themeDescription
Version: 1.0
Author: $author
*/

/* Additional CSS styles go here */"
echo "$styleContent" > "$styleFilePath"

# Generate the content for the index.php file
indexContent="<?php
// Silence is golden.
"
echo "$indexContent" > "$indexFilePath"

# Activate the custom theme
# cd "wordpress/"
# wp theme activate $themeName

# wp theme list --status=active

# Output success message
echo "Custom theme '$themeName' is geïnstalleerd en geactiveerd."
