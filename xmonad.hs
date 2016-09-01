import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.NoBorders
import XMonad.Layout.Gaps
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import Graphics.X11.ExtraTypes.XF86
import System.IO

import XMonad.Layout.IM as IM
import XMonad.Layout.Grid
import Data.Ratio ((%))
import XMonad.Layout.Spacing

main = do
  xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmonad/xmobarrc"
  xmonad $ defaultConfig
    {
        modMask = mod4Mask,
        terminal = "urxvt",
        manageHook = manageDocks <+> manageHook defaultConfig,
        layoutHook = avoidStruts $ layoutHook defaultConfig,
        logHook = dynamicLogWithPP $ xmobarPP
                            { ppOutput = hPutStrLn xmproc,
                              ppTitle = xmobarColor "green" "" . shorten 50
                            }
    } `additionalKeysP` myKeysP

myKeysP = [ ("<XF86MonBrightnessUp>",   spawn "~/bin/brightness +")
          , ("<XF86MonBrightnessDown>", spawn "~/bin/brightness -")
          , ("<XF86AudioLowerVolume>",  spawn "~/bin/volume -")
          , ("<XF86AudioRaiseVolume>",  spawn "~/bin/volume +")
          , ("<XF86AudioMute>",         spawn "~/bin/volume m")
          , ("M-<F1>",                  spawn "urxvt")
          , ("M-<F2>",                  spawn "gmrun")
          , ("M-<F3>",                  spawn "xterm")
          , ("M-<F4>",                  kill)
          , ("<Print>",                 spawn "scrot")
          ]
