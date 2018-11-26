#!/bin/bash
############################################################################    ####
#Nome: William Normandia
#Data: 22/11/2018
#Version: 0.1
#O arquivo de hots está em /etc/ansible/hosts
#
#       SOMENTE UTILIZAR ESTE SCRIPIT EM CASO DE RESTART TOTAL DOS TOMCAT
#Após a execução será necessário informar a senha do usuário mv para a execu    #ção dos comandos noser vidores PEP/SOUL/SACR nos servidores PINT a autentic    #ação já é feita automaticamente.
#
############################################################################

LIST_GROUP=`cat /etc/ansible/hosts | grep "\[" | grep -v \#`


#VERIFICA VARIAVEIS

if [ -z $1 ]; then
	echo -e "\e[01;33m Sintaxe do comando\e[00m"
	echo -e "\e[00;32m ./ansible.sh <grupo de hosts> <usuarios> <comando>\e[00m"
	echo -e "\e[01;33m Utiliza um dos grupos de host abaixo:\e[00m"
	echo -e "\e[00;32m $LIST_GROUP \e[00m"
	exit
fi

if cat /etc/ansible/hosts | grep "$1" | grep -v \# ; then
	clear
else
	echo -e "\e[01;33m Grupo de hosts n�o existe.\e[00m"
	exit
fi
	
if [ -z $2 ]; then
	echo -e "\e[01;33m E necessario informar um usuario para a execucao do scripit\e[00m"
	echo ""
	exit
fi

if [ -z $3 ]; then
	echo "Sintaxe do comando"
	echo -e "\e[01;33m E necessario informar um comando para execucao\e[00m"
	exit
fi

#INFORMATIVO  
echo -e "\e[01;33mEste scripit requer a senha do susuário$2 para ser executado \e[00m"
echo -e "\e[00;31mVocẽ esta press a executar comandos no grupo $1\e[00m"
echo -n "y/n:"
read VAR_CONFIRM

#VALIDA INFORMATIVO
if [ $VAR_CONFIRM = 'y' ]; then
        echo "yes"
else
        echo "Você optou por não continuar com a execução do scripit"
        exit
fi

clear
echo "Os comando(s) $3 $4 $5 serão executado(s) no grupo $1 utilzando ousu�rio $2" 
echo "Pressione CRTL+C para cancelar ou aguarde para continuar"
sleep 10
clear


#STATUS DO AMBIENTE
echo "digite a senha para o usu�rio $2"
ansible $1 -u $2 --ask-pass -a "$3 $4"

if [ $? == 0 ]; then
	echo "Comandos concluidos com sucesso"
else
	echo "Falha na execucao do comando $3 $4 $5"
fi

