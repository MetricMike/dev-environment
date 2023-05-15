# MTower

$DROPBOX="I:\Users\Michael\Dropbox"

# MSurface

$DROPBOX=C":\mStore\Dropbox"

cascadia code nf
https://ohmyposh.dev

# PowerToys Sync

# All powertoys settings are saved to Dropbox already so I don't care about overwriting local data

New-Item -ItemType SymbolicLink -Force -Path $env:LOCALAPPDATA\PowerToys -Target $env:DROPBOX\.powertoys

# WinGET Sync

winget import .\packages.json --accept-package-agreements --accept-source-agreements

# Non-WinGET Packages (no silent install usually)

# Battle.Net

####
VERSION=1.2.21
cd ../visualstudioexptteam.vscodeintellicode-${VERSION}
git init
git add -A
git commit -m "initial commit"
git branch -M ${VERSION}
git remote add origin git@github.com:MetricMike/vscode-intellicode.git
git push -u origin ${VERSION}

# touch the models
# 21 is done, 14 and 15 need redoign

g a -A
g c -m "cached models ${VERSION}"
git push --set-upstream origin ${VERSION} 


VERSION=1.2.21
cd ../visualstudioexptteam.vscodeintellicode-${VERSION}
prettier -w dist/intellicode.js
g c -a -m "pretty intellicode.js"
git push
