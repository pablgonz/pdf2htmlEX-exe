#!/bin/bash

function logWarn() {
	START='\033[01;33m'
	END='\033[00;00m'
	MESSAGE=${@:-""}
	echo -e "${START}${MESSAGE}${END}"
}

function logInfo() {
	START='\033[01;32m'
	END='\033[00;00m'
	MESSAGE=${@:-""}
	echo -e "${START}${MESSAGE}${END}"
}

function logError() {
	START='\033[01;31m'
	END='\033[00;00m'
	MESSAGE=${@:-""}
	echo -e "${START}${MESSAGE}${END}"
}

function log() {
        MESSAGE=${@:-""}
        echo -e "${MESSAGE}"
}

log "Mensaje con Texto Normal"
logInfo "Mensaje con Texto Informativo (Verde)"
logWarn "Mensaje con Texto para Alarma (Amarillo)"
logError "Mensaje con Texto para Error (Rojo)"
