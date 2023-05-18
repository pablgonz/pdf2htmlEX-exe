#!/bin/bash
# myscript.sh v4
# Author: Pablo González L

# texto amarillo
function log_status() {
    echo -ne "\e[33m"; echo "$@"; echo -ne "\e[0m"
}

# texto en rojo
function log_error() {
    echo -ne "\e[31m"; echo "$@"; echo -ne "\e[0m"
}

# Validate poppler version
function is_number() {
  re='^((0|[1-9][0-9]?|89)\.(0|[1-9][0-9]?)\.(0|[1-9]))$'
  if ! [[ $1 =~ $re ]] ; then
     return 1
  fi
  return 0
}

# Validate fontforge version
function is_release() {
  re='^20(19|2[0-9])(0[8-9]|1[0-2])(0[1-9]|[12][0-9]|3[01])$'
  if ! [[ $1 =~ $re ]] ; then
     return 1
  fi
  return 0
}

# Variables
yes=0
nopoppler=0
nofontforge=0
depsonly=0
ghactions=0
popplerver=""
fontforgever=""

function dohelp() {
    echo "Usage: $(basename "$0") [options]"
    echo "  -h, --help                   Prints this help message"
    echo "  -y, --yes                    Say yes to all build script prompts"
    echo "  -d, --depsonly               Only install dependencies for MSYS2"
    echo "  -g, --ghactions              Disable install local dependencies"
    echo "  -p, --poppler <version>      Install poppler <version>"
    echo "  -f, --fontforge <version>    Install fontforge <version>"
    echo "  -P, --no-poppler             Skip build/install poppler"
    echo "  -F, --no-fontforge           Skip build/install fontforge"
    exit "$1"
}

# Argumentos
while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            dohelp 0
            ;;
        -y|--yes)
            yes=$((1-yes))
            shift
            ;;
        -d|--depsonly)
            depsonly=$((1-depsonly))
            shift
            ;;
        -g|--ghactions)
            ghactions=$((1-ghactions))
            shift
            ;;
        -p|--poppler)
            if [[ -z "$2" ]]; then
                log_error "Missing value for --poppler"
                dohelp 1
            fi
            if ! is_number "$2"; then
                log_error "Invalid value for --poppler: $2 (must be numeric)"
                dohelp 1
            fi
            popplerver="$2"
            shift 2
            ;;
        -f|--fontforge)
            if [[ -z "$2" ]]; then
                log_error "Missing value for --fontforge"
                dohelp 1
            fi
            if ! is_release "$2"; then
                log_error "Invalid value for --fontforge: $2 (must be YYYYMMDD)"
                dohelp 1
            fi
            fontforgever="$2"
            shift 2
            ;;
        -P|--no-poppler)
            nopoppler=$((1-nopoppler))
            shift
            ;;
        -F|--no-fontforge)
            nofontforge=$((1-nofontforge))
            shift
            ;;
        *)
            log_error "Unknown option: $1"
            dohelp 1
            ;;
    esac
done

echo "popplerver: $popplerver"
echo "fontforgever: $fontforgever"

echo "$JAVA_HOME"

export PATH=$PATH:"$JAVA_HOME"

echo "$JAVA_HOME"

#java -version

#exit 1

command=$(powershell -NoProfile -Command "(Get-ItemProperty -Path 'HKCU:\Environment' -Name 'Path').Path | Select-String -Pattern 'java'")

if [[ -n "$command" ]]; then
  command=${command#*: }
  command=$(echo "$command" | sed -e 's/\\/\//g' -e 's/\([A-Z]\):/\/\L\1/' -e 's/;/\n/g' | grep -i 'java')

  if [[ -n "$command" ]]; then
    echo "$command" | head -n 1
  else
    echo "No se encontró la ruta de Java en el registro."
  fi
else
  echo "No se encontró la ruta de Java en el registro."
fi

# test
java -version

exit 1











command=$(powershell -NoProfile -Command "(Get-ItemProperty -Path 'HKCU:\Environment' -Name 'Path').Path | Select-String -Pattern 'java'")

if [[ -n "$command" ]]; then
  command=${command#*: }
  command=$(echo "$command" | sed -e 's/\\/\//g' -e 's/^C:/\/c/' -e 's/;/\n/g' | grep -i 'java')

  if [[ -n "$command" ]]; then
    echo "$command" | head -n 1
  else
    echo "No se encontró la ruta de Java en el registro."
  fi
else
  echo "No se encontró la ruta de Java en el registro."
fi

exit 1















command=$(powershell -NoProfile -Command "(Get-ItemProperty -Path 'HKCU:\Environment' -Name 'Path').Path | Select-String -Pattern 'java'")

if [[ -n "$command" ]]; then
  command=${command#*: }
  command=$(echo "$command" | sed -e 's/\\/\//g' -e 's/^C:/\/c/' -e 's/;/\n/g' | grep 'java')

  echo "$command"
else
  echo "No se encontró la ruta de Java en el registro."
fi

exit 1



command=$(powershell -NoProfile -Command "(Get-ItemProperty -Path 'HKCU:\Environment' -Name 'Path').Path | Select-String -Pattern 'java'")

if [[ -n "$command" ]]; then
  command=${command#*: }
  command=$(echo "$command" | sed -e 's/\\/\//g' -e 's/^C:/\/c/' -e 's/;/\n/g')

  while IFS= read -r path; do
    echo "$path"
  done <<< "$command"
else
  echo "No se encontró la ruta de Java en el registro."
fi


exit 1
