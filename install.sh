#!/bin/bash -e

pushd $(dirname $0) > /dev/null
  SCRIPTPATH=$(pwd)
popd > /dev/null

function install_file {
  SRC=$1
  DST=$2
  if [[ -f $DST && ! -L $DST ]] ; then mv $DST $DST.old; fi
  ln -sf $SRC $DST
}
install_file "$SCRIPTPATH/.bashrc" ~/.bashrc
install_file "$SCRIPTPATH/.prompt" ~/.prompt
install_file "$SCRIPTPATH/.bash_aliases" ~/.bash_aliases
install_file "$SCRIPTPATH/.config/compton.conf" ~/.config/compton.conf

mkdir -p ~/.fonts
cp $SCRIPTPATH/.fonts/* ~/.fonts/

mkdir -p ~/.config/i3/
install_file "$SCRIPTPATH/.config/i3/config" ~/.config/i3/config
install_file "$SCRIPTPATH/.config/i3/i3blocks.conf" ~/.config/i3/i3blocks.conf
mkdir -p ~/.config/i3/scripts
install_file "$SCRIPTPATH/.config/i3/scripts/wallpaper.sh" ~/.config/i3/scripts/wallpaper.sh
install_file "$SCRIPTPATH/.config/i3/scripts/lock.sh" ~/.config/i3/scripts/lock.sh

mkdir -p ~/.config/gtk-3.0/
install_file "$SCRIPTPATH/.config/gtk-3.0/settings.ini" ~/.config/gtk-3.0/settings.ini
install_file "$SCRIPTPATH/.gtkrc-2.0" ~/.gtkrc-2.0

mkdir -p ~/.config/terminator/
install_file "$SCRIPTPATH/.config/terminator/config" ~/.config/terminator/config

sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install terminator i3 i3blocks redshift-gtk keepass2 pass undistract-me steam python3-dev python3-pip rofi feh compton ffmpeg
sudo pip3 install virtualenvwrapper
sudo dpkg-reconfigure keyboard-configuration

sudo add-apt-repository -u ppa:snwh/ppa
sudo apt-get install moka-icon-theme faba-icon-theme faba-mono-icons

sudo add-apt-repository ppa:noobslab/themes
sudo apt-get install arc-theme
