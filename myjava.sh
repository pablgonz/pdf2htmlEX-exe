#!/bin/bash
# Set executable for JAVA
#
# First we look for if the environment variable JAVA_HOME is defined in
# Windows, otherwise we look for the executable in the PATH of Windows,
# if found set it to MSYS2 (without this java cannot be executed).
if [[ -n "$JAVA_HOME" ]]; then
    JAVA_HOME=$(echo "$JAVA_HOME" | sed -e 's/\\/\//g' -e 's/\([A-Z]\):/\/\L\1/g' )
    export PATH="$PATH:$JAVA_HOME/bin"
    JAVA_EXEC=$(find "$JAVA_HOME" -name 'java.exe' -type f -print -quit)
    JAVA_VER=$(java -version 2>&1 | head -n 1)

else
    JAVA_HOME=$(powershell -NoProfile -Command "(Get-ItemProperty -Path 'HKCU:\Environment' -Name 'Path').Path | Select-String -Pattern 'java'")
    if [[ -n "$JAVA_HOME" ]]; then
        JAVA_HOME=$(echo "$JAVA_HOME" | sed -e 's/\([A-Z]\):/\/\L\1/g' -e 's/\\/\//g' -e 's/;/\n/g'  | grep -i 'java')
        export PATH="$PATH:$JAVA_HOME"
        JAVA_EXEC=$(find "$JAVA_HOME" -name 'java.exe' -type f -print -quit)
        JAVA_VER=$(java -version 2>&1 | head -n 1)
    fi
fi

# Test for --help
if [[ -z "$JAVA_VER" ]]; then
    JAVA_VER="Could not detect java installed"
fi

exit 0
















#!/bin/bash
# Set executable for JAVA
#
# Primero buscamos si la variable de entorno JAVA_HOME está definida en
# Windows, en caso contrario buscamos el ejecutable en el PATH de Windows
# y la establecemos en MSYS2 (sin está variable no se pude ejecutar java)
# Si fallan las dos condiciones devolvemos error.
if [[ -n "$JAVA_HOME" ]]; then
    JAVA_HOME=$(echo "$JAVA_HOME" | sed -e 's/\\/\//g' -e 's/\([A-Z]\):/\/\L\1/g' )
    echo "ESTE ES : $JAVA_HOME"
    export PATH="$PATH:$JAVA_HOME/bin"
    echo "Found JAVA_HOME:$JAVA_HOME"
    JAVA_EXEC=$(find "$JAVA_HOME" -name 'java.exe' -type f -print -quit)
    echo "JAVA_EXEC: $JAVA_EXEC"
    # TEST
    #java -version
elif JAVA_HOME=$(powershell -NoProfile -Command "(Get-ItemProperty -Path 'HKCU:\Environment' -Name 'Path').Path | Select-String -Pattern 'java'"); then
    if [[ -n "$JAVA_HOME" ]]; then
        JAVA_HOME=$(echo "$JAVA_HOME" | sed -e 's/\([A-Z]\):/\/\L\1/g' -e 's/\\/\//g' -e 's/;/\n/g'  | grep -i 'java')
        echo "Set JAVA_HOME: $JAVA_HOME"
        export PATH="$PATH:$JAVA_HOME"
        JAVA_EXEC=$(find "$JAVA_HOME" -name 'java.exe' -type f -print -quit)
        echo "JAVA_EXEC: $JAVA_EXEC"
        # TEST
        # java -version
    fi
else
    echo "No se pudo establecer JAVA_HOME ni encontrar el ejecutable de java"
fi

#java_version_line=$(java -version 2>&1 | head -n 1)
#echo "$java_version_line"


if [[ -z "$java_version_line" ]]; then
    echo "No se encontró el ejecutable de Java."
fi

exit 0


java -version devuelve (dependiendo si es Openjdk o si es Oracle)

openjdk version "20.0.1" 2023-04-18
OpenJDK Runtime Environment (build 20.0.1+9-29)
OpenJDK 64-Bit Server VM (build 20.0.1+9-29, mixed mode, sharing)

java version "1.8.0_361"
Java(TM) SE Runtime Environment (build 1.8.0_361-b09)
Java HotSpot(TM) 64-Bit Server VM (build 25.361-b09, mixed mode)


if [[ -n "$JAVA_EXE" ]]; then
    echo "$JAVA_EXE"
else
    echo "No se encontró el ejecutable de Java."
fi

java -version
exit 0


















if [[ -n "$JAVA_HOME" ]]; then
    JAVA_HOME=$(echo "$JAVA_HOME" | sed -e 's/\\/\//g' -e 's/\([A-Z]\):/\/\L\1/' )
    export PATH="$PATH:$JAVA_HOME/bin"
    #export PATH=$PATH:"/c/Program\ Files/Java/jre1.8.0_361/bin" ## -e 's/ /\\\ /g'
    JAVA_EXE=$(find "$JAVA_HOME" -path '*/bin/java.exe' -type f -print -quit 2>/dev/null)
    echo "$JAVA_HOME"
    # Test
    #JAVA_EXE="$JAVA_HOME/java.exe"
    echo "$JAVA_EXE"
    java="$JAVA_EXE"
    java -version
else
   echo "The path to the java executable (java.exe) was not detected"
   echo "Having java installed is required for compilation of pdf2htmlEX"
   echo "Install Java and set JAVA_HOME in environmet variables"
fi

#echo "$JAVA_EXE -version"

#java -version
exit 1








# Set executable for JAVA
if [[ -n "$JAVA_HOME" ]]; then
    JAVA_HOME=$(echo "$JAVA_HOME" | sed -e 's/\\/\//g' -e 's/\([A-Z]\):/\/\L\1/' )
    export PATH=$PATH:"$JAVA_HOME/bin"
    JAVA_EXE=$(find "$JAVA_HOME" -name 'java.exe' -type f -print -quit)
else
    JAVA_PATH=$(powershell -NoProfile -Command "(Get-ItemProperty -Path 'HKCU:\Environment' -Name 'Path').Path | Select-String -Pattern 'java'")
    if [[ -n "$JAVA_PATH" ]]; then
        JAVA_PATH=${JAVA_PATH#*: }
        JAVA_PATH=$(echo "$JAVA_PATH" | sed -e 's/\\/\//g' -e 's/\([A-Z]\):/\/\L\1/' -e 's/;/\n/g' | grep -i 'java')
        export PATH=$PATH:"$JAVA_PATH"
        JAVA_EXE=$(find "$JAVA_PATH" -name 'java.exe' -type f -print -quit)
    fi
fi

if [[ -n "$JAVA_EXE" ]]; then
    echo "$JAVA_EXE"
else
    echo "No se encontró el ejecutable de Java."
fi

java -version
exit 1
