#!/usr/bin/env bash

# Build script for the MolView source code (Termux-friendly version)

# Function: render_svg_to_png
# Uses ImageMagick instead of Inkscape
render_svg_to_png() {
    local SRC=$1
    local DEST=$2
    local WIDTH=$3
    local HEIGHT=$4

    if [[ -f $SRC ]]; then
        echo "Rendering $SRC -> $DEST (${WIDTH}x${HEIGHT})"
        magick convert -background none -resize ${WIDTH}x${HEIGHT} "$SRC" "$DEST"
    else
        echo "⚠️ Missing source SVG: $SRC"
    fi
}

# Handle "fetch" option
if [[ $1 == "fetch" ]]; then
    if [[ $2 == "jmol" ]]; then
        echo "📥 Downloading JSmol..."
        if [[ $3 == "nightly" ]]; then
            wget -O Jmol.zip http://chemapps.stolaf.edu/jmol/zip/Jmol.zip
            unzip Jmol.zip jsmol.zip
        else
            wget -O Jmol.zip http://sourceforge.net/projects/jmol/files/latest/download?source=files
            unzip -j Jmol.zip */jsmol.zip
        fi
        unzip jsmol.zip
        mv jsmol/JSmol.min.js src/js/lib/JSmol.min.js
        rm -r jmol
        mkdir jmol
        mv jsmol/j2s jmol/j2s
        rm -r jsmol jsmol.zip Jmol.zip
    fi

    echo "📥 Downloading Parsedown..."
    wget https://raw.githubusercontent.com/erusev/parsedown/master/Parsedown.php -O php/Parsedown.php
fi

# Skip rendering step if called explicitly
if [[ $1 != "render" ]]; then
    echo "📦 Installing dependencies..."
    bower install --allow-root
    grunt
fi

# Create output directory
mkdir -p img

# Render all necessary images (replace Inkscape with ImageMagick)
render_svg_to_png src/svg/icon/mark.svg img/mark.png 1050 256
render_svg_to_png src/svg/icon/48.svg img/logo.png 256 256
render_svg_to_png src/svg/icon/square.svg img/maskable-192x192.png 192 192
render_svg_to_png src/svg/icon/16.svg favicon-16x16.png 16 16
render_svg_to_png src/svg/icon/16.svg favicon-24x24.png 24 24
render_svg_to_png src/svg/icon/16.svg favicon-32x32.png 32 32
render_svg_to_png src/svg/icon/16.svg favicon-64x64.png 64 64
render_svg_to_png src/svg/icon/48.svg img/logo-512x512.png 512 512

# Create favicon.ico
if [[ -f favicon-16x16.png ]]; then
    magick convert favicon-16x16.png favicon-24x24.png favicon-32x32.png favicon-64x64.png favicon.ico
    echo "✅ favicon.ico created."
else
    echo "⚠️ favicon images missing, favicon.ico not created."
fi

echo "🎉 Build complete!"
