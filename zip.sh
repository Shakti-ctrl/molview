
#!/bin/bash

# Create MolView.zip for web app deployment
# Excluding android folder and unnecessary build files

zip -r MolView.zip \
	build \
	img \
	jmol \
	pages \
	php \
	embed \
	docs \
	src \
	www \
	.htaccess \
	robots.txt \
	index.html \
	page.php \
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
	-x "android/*" "*/node_modules/*" "*/.git/*" "*/.gradle/*" "*/build/intermediates/*" "*/build/outputs/*"

echo "Created MolView.zip successfully!"
ls -la MolView.zip
