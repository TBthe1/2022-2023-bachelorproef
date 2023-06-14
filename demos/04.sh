#!/bin/bash
# Script name: install_woocommerce.sh

# Set the plugins path
pluginsPath="$PWD"

# WooCommerce plugin download URL
woocommerceUrl="https://downloads.wordpress.org/plugin/woocommerce.latest-stable.zip"

# WooCommerce plugin name and downloaded ZIP file name
woocommerceName="woocommerce" 
woocommerceFileName="$woocommerceName.zip"

# Download WooCommerce plugin
woocommerceFilePath="$PWD/$woocommerceFileName"
wget "$woocommerceUrl" -O "$woocommerceFilePath"

# Extract WooCommerce plugin to the plugins folder
7z x "$woocommerceFilePath" -o"$pluginsPath"

# Delete the zipped download file
rm "$woocommerceFilePath"

# Display success message
echo "WooCommerce plugin is downloaded, unzipped, and the zipped download is deleted."
