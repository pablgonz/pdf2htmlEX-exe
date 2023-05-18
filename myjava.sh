#!/bin/bash
# Detección de java bajo MSYS2

read -r -d '' usage <<-EOF
Usage: `basename $0` [options]

    -h, --help                Prints this help message
    -y, --yes                 Say yes to all build script prompts
    -d, --depsonly            Only install dependencies for MSYS2
    -g, --ghactions           Disable install local dependencies
    -p, --poppler <version>   Install poppler <version>
    -P, --no-poppler          Skip build/install poppler
    -F, --no-fontforge        Skip build/install fontforge

Note: Nedd defined $JAVA_HOME or set java.exe under PATH

EOF
echo "$usage"

if [[ -n "$JAVA_HOME_8_X64" ]]; then
JAVA_HOME_8_X64
    echo "Se encontró definida la variable de entorno Windows: JAVA_HOME_8_X64."
    echo "$JAVA_HOME_8_X64"
    echo "Añadiendo ruta al ejecutable en MSYS2."
    JAVA_HOME_8_X64=$(echo "$JAVA_HOME_8_X64" | sed -e 's/\\/\//g' -e 's/\([A-Z]\):/\/\L\1/' )
    export PATH=$PATH:"$JAVA_HOME_8_X64/bin"
    # Test
    java -version
fi

exit 1




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
