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
mkdir $HOME/.config/picom
mkdir $HOME/.icons
mkdir $HOME/.themes



#[en]Install repositories and apps
#[es]Instalando repocitorios y apps:

echo -e $PASSWD | sudo -S add-apt-repository ppa:xubuntu-dev/staging && echo -e $PASSWD | sudo -S apt update
echo -e $PASSWD | sudo -S apt install xfce4-docklike-plugin mate-applet-appmenu mate-applets mate-applets-common mate-panel dconf-cli wget dconf-editor

wget -P $HOME/.local/Mkos https://github.com/zayronxio/script-Mkos/raw/master/Paquetes/picom-ibhagwan-lasted.deb
echo -e $PASSWD | sudo -S dpkg -i $HOME/.local/Mkos/picom-ibhagwan-lasted.deb
echo -e $PASSWD | sudo -S apt --fix-broken install
wget -P $HOME/.local/Mkos https://github.com/zayronxio/script-Mkos/raw/master/Paquetes/lightpad_0.0.8.rev1_amd64.deb
echo -e $PASSWD | sudo -S dpkg -i $HOME/.local/Mkos/lightpad_0.0.8.rev1_amd64.deb




#Added Config file of picom
echo "Added Config file of picom"
wget -P $HOME/.config/picom "https://github.com/zayronxio/script-Mkos/raw/master/Config Picom/picom.conf"


##### Agregando Configs para paneles####
echo "Config panel xfce4"
wget -P $HOME/.local/Mkos https://github.com/zayronxio/script-Mkos/raw/master/Paquetes/XFCEDOCK.tar.bz2
xfce4-panel-profiles load $HOME/.local/Mkos/XFCEDOCK.tar.bz2
echo "Config panel mate"
wget -P $HOME/.local/Mkos https://github.com/zayronxio/script-Mkos/raw/master/Mate-panel/Mkos.layout && echo -e $PASSWD | sudo -S mv $HOME/.local/Mkos/Mkos.layout /usr/share/mate-panel/layouts/Mkos.layout

#####Agregando Iconos#######
if zenity --question --text "You want to add mac os style icons" 
 then
wget -P $HOME/.icons https://github.com/zayronxio/script-Mkos/raw/master/Icons/Mkos-Big-Sur.tar.xz && cd $HOME/.icons && tar -Jxvf Mkos-Big-Sur.tar.xz && cd
else
echo "the iconos have been installed"
 fi
 
wget -P $HOME/.themes https://github.com/zayronxio/script-Mkos/raw/master/themes/BigSur-XFCE.tar.xz && cd $HOME/.themes && tar -Jxvf BigSur-XFCE.tar.xz && cd


#Change Thunar
xfconf-query -c thunar -p /last-location-bar -s ThunarLocationButtons && xfconf-query -c thunar -p /last-separator-position -s 180 && xfconf-query -c thunar -p /last-side-pane -s ThunarShortcutsPane && xfconf-query -c thunar -p /last-window-height -s 410 && xfconf-query -c thunar -p /last-window-width -s 700 && xfconf-query -c thunar -p /last-icon-view-zoom-level -s THUNAR_ZOOM_LEVEL_150_PERCENT && thunar -q

 #cambiando iconos y thema
echo "change icons and themes"
xfconf-query -c xsettings -p /Net/IconThemeName -s Mkos-Big-Sur
xfconf-query -c xsettings -p /Net/ThemeName -s BigSur-XFCE
xfconf-query -c xfwm4 -p /general/theme -s BigSur-XFCE
xfconf-query --channel=xfwm4 --property=/general/use_compositing --type=bool --toggle
picom &

#change Mate-panel
mate-panel &
dconf write /org/mate/panel/general/default-layout "'Mkos'"
mate-panel --reset
sleep 3s
dconf write /org/mate/panel/toplevels/top/background/color "'rgba(0,0,0,0.0649882)'"
dconf write /org/mate/panel/toplevels/top/background/type "'color'"

#apps autostar
wget -P $HOME/.config/autostart https://github.com/zayronxio/script-Mkos/raw/master/Autostart/picom.desktop
wget -P $HOME/.config/autostart https://github.com/zayronxio/script-Mkos/raw/master/Autostart/mate-panel.desktop
 
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


