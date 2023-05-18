#!/bin/bash

# Detección del ejecutable de java bajo MSYS2

# Si está definida en el entorno de variables Windows local la podemos capturar
if [[ -n "$JAVA_HOME" ]]; then
    echo "Se encontró definida la variable de entorno (Windows) JAVA_HOME."
    JAVA_HOME=$(echo "$JAVA_HOME" | sed -e 's/\\/\//g' -e 's/\([A-Z]\):/\/\L\1/' )
    export PATH=$PATH:"$JAVA_HOME/bin"
    # Test
    java -version
fi

# Si está definida en el entorno de variables Windows en github acctions la podemos capturar
if [[ -n "$JAVA_HOME_8_X64" ]]; then
    echo "Se encontró definida la variable de entorno (Windows) JAVA_HOME_8_X64."
    JAVA_HOME_8_X64=$(echo "$JAVA_HOME_8_X64" | sed -e 's/\\/\//g' -e 's/\([A-Z]\):/\/\L\1/' )
    export PATH=$PATH:"$JAVA_HOME_8_X64/bin"
    # Test
    java -version
fi

# Si fallan las dos anteriores buscamos en el PATH de windows
JAVA_PATH=$(powershell -NoProfile -Command "(Get-ItemProperty -Path 'HKCU:\Environment' -Name 'Path').Path | Select-String -Pattern 'java'")

if [[ -n "$JAVA_PATH" ]]; then
  JAVA_PATH=${JAVA_PATH#*: }
  JAVA_PATH=$(echo "$JAVA_PATH" | sed -e 's/\\/\//g' -e 's/\([A-Z]\):/\/\L\1/' -e 's/;/\n/g' | grep -i 'java')

  if [[ -n "$JAVA_PATH" ]]; then
    echo "Se encontró la ruta del ejecutable de java en el PATH de Windows."
    JAVA_PATH=$(echo "$JAVA_PATH" | head -n 1)
    export PATH=$PATH:"$JAVA_PATH"
    # Test
    java -version
  else
    echo "No se encontró la ruta del ejecutable de java en el PATH de Windows."
  fi
else
  echo "No se encontró la ruta del ejecutable de java en el PATH de Windows."
fi

exit 1

