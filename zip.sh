
#!/bin/bash

# Create a clean zip file for web app deployment
# Excluding android folder and unnecessary build files

zip -r MolView-WebApp.zip \
	src \
	www \
	php \
	pages \
	docs \
	embed \
	img \
	jmol \
	.htaccess \
	robots.txt \
	index.html \
	page.php \
	favicon.ico \
	manifest.json \
	php.ini \
	package.json \
	bower.json \
	Gruntfile.js \
	build.sh \
	README.md \
	COPYRIGHT.md \
	LEGAL.md \
	replit.md \
	capacitor.config.json \
	-x "*/build/*" "*/node_modules/*" "*/.gradle/*" "*/intermediates/*" "*/outputs/*" "*/.git/*"

echo "Created MolView-WebApp.zip excluding android and build files"
