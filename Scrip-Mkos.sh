#!/bin/bash
##[es] Script para cambiar apariencia de xubuntu 21.04. 
##[en] Script for change the xubuntu 21.04 appearance 
#Creator: Adolfo Silerio a.k.a ZAYRONXIO
#mail: zayronxio@gmail.com
###########

#[en]set variables
PASSWD="$(zenity --password --title=Authentication)\n"
###
#[en]verified distro
#[es]Verificado distro
DISTRO=$(lsb_release -d)
Desktopsession=$(env | grep DESKTOP_SESSION)
if [ "$DISTRO" = "Description:	Ubuntu 21.04" ];
 then
   if echo $Desktopsession = "DESKTOP_SESSION=xubuntu";
     then

#######
#[en]Created required directories
echo "Created required directories"
mkdir $HOME/.local/Mkos

#[en]Install repositories and apps
#[es]Instalando repocitorios y apps:

echo -e $PASSWD | sudo -S add-apt-repository ppa:xubuntu-dev/staging && echo -e $PASSWD | sudo -S apt update
echo -e $PASSWD | sudo -S apt install xfce4-docklike-plugin mate-applet-appmenu mate-applets mate-applets-common mate-panel wget

wget -P $HOME/.local/Mkos https://github.com/zayronxio/script-Mkos/raw/master/Paquetes/picom-ibhagwan-lasted.deb
echo -e $PASSWD | sudo -S dpkg -i $HOME/.local/Mkos/picom-ibhagwan-lasted.deb && echo -e $PASSWD | sudo -S apt --fix-broken install
 else 
  zenity --info \
       --title="Mkos" \
       --width=250 \
       --text="Usted esta usando una distro o un desktop no permitido"
       fi
         else 
         zenity --info \
          --title="Mkos" \
           --width=250 \
            --text="Usted esta usando una distro o un desktop no permitido"
       fi


