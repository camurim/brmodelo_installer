#!/usr/bin/env bash

# Instala pré-requisitos
[[ $(dpkg -s wget >/dev/null 2>&1) -ne 0 ]] && apt-get install wget -y

TARGET="$HOME"/usr/java/brModelo
mkdir -p "$TARGET"
wget --continue http://www.sis4.com/brModelo/brModelo.jar -O "$TARGET"/brModelo.jar
wget --continue https://raw.githubusercontent.com/chcandido/brModelo/master/src/imagens/icone.png -O "$TARGET"/icon.png

script=$(
	cat <<-'_EOF_'
		#!/usr/bin/env bash
		SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
		java -jar "$SCRIPT_DIR"/brModelo.jar
	_EOF_
)

shortcut=$(
	cat <<-_EOF_
		[Desktop Entry]
		Name=brModelo
		Exec=$TARGET/brmodelo
		Icon=$TARGET/icon.png
		comment=Case
		Type=Application
		Terminal=false
		Encoding=UTF-8
		Categories=Development;
	_EOF_
)

mkdir -p "$HOME"/.local/share/applications
echo "$script" >"$TARGET"/brmodelo
echo "$shortcut" >"$HOME"/.local/share/applications/brModelo.desktop
chmod +x "$TARGET"/brmodelo
chmod +x "$HOME"/.local/share/applications/brModelo.desktop

echo "Concluído!"
