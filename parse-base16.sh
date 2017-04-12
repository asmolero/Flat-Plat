#!/bin/sh


if [[ -n $1 ]]
then
	scheme=$1
else
	scheme=tomorrow
fi

echo Using scheme $scheme

base16-builder -s $scheme -t src/gtk-2.0/assets.svg.ejs > src/gtk-2.0/assets.svg
base16-builder -s $scheme -t src/gtk-2.0/gtkrc.ejs > src/gtk-2.0/gtkrc
base16-builder -s $scheme -t src/gtk-3.0/gtk-common/assets.svg.ejs > src/gtk-3.0/gtk-common/assets.svg
base16-builder -s $scheme -t src/gtk-3.0/3.22/sass/_colors.scss.ejs > src/gtk-3.0/3.22/sass/_colors.scss

rm -f src/gtk-2.0/assets/*.png
(cd src/gtk-2.0/; ./render-assets.sh)

rm -f src/gtk-3.0/gtk-common/assets/*.png
(cd src/gtk-3.0/gtk-common/; ./render-assets.sh)

sed -i s/SCHEME/$scheme/g src/*.theme
sed -i s/SCHEME/$scheme/g install.sh
