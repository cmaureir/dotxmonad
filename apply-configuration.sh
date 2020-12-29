#!/bin/bash

mkdir -p ~/.xmonad || echo "Error creating ~/.xmonad directory"
/bin/cp -f xmobarrc  ~/.xmonad/ || echo "Error copying 'xmobarrc'"
/bin/cp -f xmonad.hs ~/.xmonad/ || echo "Error copying 'xmonad.hs'"
/bin/cp -f .xprofile  ~/.xprofile || echo "Error copying '.xprofile'"
