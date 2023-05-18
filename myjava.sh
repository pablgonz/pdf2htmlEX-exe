#!/bin/bash
# Detección de java bajo MSYS2

# Si está definida en el entorno de variables Windows
if [[ -n "$JAVA_HOME" ]]; then
    echo "Se encontró definida la variable de entorno Windows: JAVA_HOME."
    echo "Añadiendo ruta al ejecutable en MSYS2."
    JAVA_HOME=$(echo "$JAVA_HOME" | sed -e 's/\\/\//g' -e 's/\([A-Z]\):/\/\L\1/' )
    export PATH=$PATH:"$JAVA_HOME/bin"
    # Test
    java -version
elif JAVA_PATH=$(powershell -NoProfile -Command "(Get-ItemProperty -Path 'HKCU:\Environment' -Name 'Path').Path | Select-String -Pattern 'java'"); then
    JAVA_PATH=${JAVA_PATH#*: }
    JAVA_PATH=$(echo "$JAVA_PATH" | sed -e 's/\\/\//g' -e 's/\([A-Z]\):/\/\L\1/' -e 's/;/\n/g' | grep -i 'java')

    if [[ -n "$JAVA_PATH" ]]; then
        echo "Se encontró la ruta del ejecutable de java en el PATH de Windows."
        echo "Añadiendo ruta al ejecutable en MSYS2."
        JAVA_PATH=$(echo "$JAVA_PATH" | head -n 1)
        export PATH=$PATH:"$JAVA_PATH"
        # Test
        java -version
    else
        echo "No se encontró la ruta del ejecutable de java en el PATH de Windows."
    fi
else
    echo "No se pudo añadir la ruta al ejecutable de java en MSYS2."
fi

exit 1
