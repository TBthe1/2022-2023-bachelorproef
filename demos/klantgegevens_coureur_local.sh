#!/bin/bash
# Configuratiebestand voor WordPress-installatie
# Naam = klantgegevens_coureur_local.sh

# Database-instellingen
dbName="wp_coureur_locallllll"
dbUser="root"
dbPassword=""
dbHost="localhost"
dbPort="3306"
dbPrefix="wp_"

# Site-instellingen
siteTitle="Coureur Local"
siteDescription="Koop bij ons jouw nieuwe fiets."
siteTimezone="Europe/Amsterdam"
siteLanguage="nl_NL"
siteUrl="https://coureurlocal.be"

# Standaard gebruiker instellen
defaultUsername="Admin"
defaultPassword="admin_wachtwoord"
defaultEmail="admin@teammade.be"

# WordPress-map pad
wordpressPath="C:/Users/Bjorn/Desktop/local_repos/hogent/bachelorproef/coureur_local/wordpress"

# Thema instellingen
author="Team Made"
themesPath="/wordpress/wp-content/themes"
themeName="Thema Coureur Local"
themeDescription="Thema speciaal voor Coureur Local gemaakt."

# Exporteer variabelen voor gebruik in andere scripts
export dbName
export dbUser
export dbPassword
export dbHost
export dbPort
export dbPrefix
export siteTitle
export siteDescription
export siteTimezone
export siteLanguage
export siteUrl
export defaultUsername
export defaultPassword
export defaultEmail
export wordpressPath
export author
export themesPath
export themeName
export themeDescription
