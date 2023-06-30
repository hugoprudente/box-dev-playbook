#!/bin/bash

#

# Bootstrap Python venv and Ansible for a new workstation.

#

#Author: Hugo Prudente

#
# --------------------------------------------------------------
# If you are boostraping a new machine without the old machine to
# ssh over, you will need the basic requirements of python venv and
# ansible to be able to run the setup.
# --------------------------------------------------------------
#
#@ History:
#@ v0.1 - 2009/02/05 - Hugo Prudente:
#@   Created this skeleton with menu options
#@ v1.0 - 2023/06/30 - Hugo Prudente:
#@   Developed the script that does the core setup for new workstation
#@
#@
# [ GLOBAL ]
#
HELP="
$(basename $0) [opcões]

Opções:

-V  Version
-h  Help
-H  History revison of $(basename $0)
"

# 
# [ Globals ]
# Here lays the globals vars

DIRECTORY="$HOME/Environments/"
ANSIBLE_VERSION=${ANSIBLE_VERSION=2.12.10}

#
# [ Functions ]
# Aqui você coloca as funções caso existeam.

function SetupPythonVenv(){
  mkdir -p $DIRECTORY
  echo "Creating `python3 --version` venv on $ENV"
  python3 -m venv $DIRECTORY/$ENV
  source $DIRECTORY/$ENV/bin/activate
  pip install --upgrade pip
}


#
# [ MENU OPCOES ]
# Menu de opções ./$0 -h -V -H

###Ele verifica se existem opções seguintes do $0 sendo elas listadas em aqui = ":VhH"
###caso sim ele atribui em "opcao" e verifica no case a saida.

while getopts ":VhH" opcao
do
case $opcao in
V)
echo "Version: `grep "v\([0-9].[0-9]\)" "$0" |\
tail -1 | cut -d "-" -f 1 | tr -d \#`"
exit 0
;;
h)
echo "$HELP"
exit 0
;;
H)
grep "#@" "$0" | less
exit 0
;;
*)
if [ ! -z $opcao ];then
exit 0
fi
;;
esac
done

#
# [ DESENVOLVIMENTO ]
#

cd ~

if [ -z $1 ];then
  ENV=env
else
  ENV=$1
fi

SetupPythonVenv

echo "Installing ansible $ANSIBLE_VERSION"
pip install ansible-core==$ANSIBLE_VERSION
