php -c $PREFIX/etc/php/php.ini -S localhost:8000
php -c $PREFIX/etc/php/php.ini -S 0.0.0.0:5000





🔹 Step 1: Update Termux & Install Core Dependencies

pkg update && pkg upgrade -y
pkg install -y nodejs npm php imagemagick git wget unzip

This updates Termux and installs all the base packages you’ll need:

Node.js & npm for running JavaScript and installing frontend tools.

PHP to serve MolView.

ImageMagick for basic image rendering (we’ll skip Inkscape here because it’s not in Termux).

Git, wget, unzip for downloading and unpacking dependencies.



---

🔹 Step 2: Install Global Node.js Tools

npm install -g bower grunt-cli

Installs:

Bower: Frontend package manager for MolView.

Grunt CLI: Task runner for building assets.



---

🔹 Step 3: Clone the MolView Repo

rm -rf molview
git clone -b main https://github.com/Shakti-ctrl/molview.git
cd molview

This removes any old molview folder, clones the latest version from your GitHub main branch, and enters the project folder.


---

🔹 Step 4: Install Project Dependencies

npm install
bower install --allow-root

npm install installs all Node.js dependencies for the build.

bower install fetches frontend libraries used by MolView.



---

🔹 Step 5: Build the Project

grunt
mkdir -p img
chmod +x build.sh
./build.sh render || echo "⚠️ Skipping render step (Inkscape not installed)"

This compiles MolView’s assets.

grunt runs build tasks.

mkdir -p img ensures an image folder exists.

./build.sh render generates SVGs (skips if no Inkscape).



---

🔹 Step 6: Fetch External Dependencies

./build.sh fetch jmol
./build.sh fetch

Downloads Jmol and PHP dependencies like Parsedown.


---

🔹 Step 7: Prepare Upload & Database Directories

mkdir -p php/uploads/structures
mkdir -p php/uploads/animations
mkdir -p php/data

This creates all necessary folders for uploaded files and database storage.


---

🔹 Step 8: Start the PHP Development Server

php -S 0.0.0.0:5000

Runs a local web server.
Your MolView app will be available at:
http://localhost:5000 (or http://<device-ip>:5000 from other devices).
