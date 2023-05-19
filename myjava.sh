#!/bin/bash
# Set executable for JAVA

# Set executable for JAVA
if [[ -n "$JAVA_HOME" ]]; then
    JAVA_HOME=$(echo "$JAVA_HOME" | sed -e 's/\\/\//g' -e 's/\([A-Z]\):/\/\L\1/' )
    export PATH="$PATH:$JAVA_HOME/bin"
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
