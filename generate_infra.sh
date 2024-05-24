#!/bin/bash

# Directorio de salida
OUTPUT_DIR="output"
TEMPLATE_DIR="templates/backend"  # Directorio donde se almacenan las plantillas

# Nombres y prefijos personalizados
APP_NAME="MRGamingBackend"
RESOURCE_PREFIX="MGB"

# Crear el directorio de salida si no existe
mkdir -p "$OUTPUT_DIR"

# Encabezado del archivo combinado
combined_content="AWSTemplateFormatVersion: '2010-09-09'
Description: Plantilla de CloudFormation para crear la infraestructura de la aplicación

Parameters:
  VpcCidr:
    Type: String
    Default: \"10.0.0.0/16\"
  PublicSubnetCidr:
    Type: String
    Default: \"10.0.1.0/24\"
  PrivateSubnetCidr:
    Type: String
    Default: \"10.0.2.0/24\"
  AppName:
    Type: String
    Default: \"$APP_NAME\"
  ResourcePrefix:
    Type: String
    Default: \"$RESOURCE_PREFIX\"
  EndpointIp:
    Type: String
    Default: \"203.0.113.0/24\"

Resources:
"

# Leer y combinar todas las plantillas
for template_file in "$TEMPLATE_DIR"/*.yaml; do
  content=$(cat "$template_file")
  
  # Reemplazar los placeholders
  content=${content//MRGApp/$APP_NAME}
  content=${content//MRG/$RESOURCE_PREFIX}

  # Retirar las líneas hasta "Resources:"
  filtered_content=$(echo "$content" | sed -n '/Resources:/,$p' | tail -n +2)

  # Añadir contenido al archivo combinado
  combined_content+="# ${template_file##*/}\n"
  combined_content+="$filtered_content\n\n"
done

# Escribir el archivo combinado
output_file="$OUTPUT_DIR/combined_template.yaml"
echo -e "$combined_content" > "$output_file"

echo "Archivo combinado generado en $output_file"
