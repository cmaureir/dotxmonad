import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Util.EZConfig(additionalKeysP)
import XMonad.Layout.NoBorders(smartBorders)
import XMonad.Util.Run(spawnPipe)
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Gaps
import Graphics.X11.ExtraTypes.XF86
import System.IO
import XMonad.Layout.IM as IM
import XMonad.Layout.Grid
import Data.Ratio ((%))
import XMonad.Layout.Spacing

--        manageHook = manageDocks <+> manageHook defaultConfig,
--        layoutHook = avoidStruts $ layoutHook defaultConfig,
myConfig = defaultConfig
        { manageHook = ( isFullscreen --> doFullFloat ) <+> manageDocks <+> manageHook defaultConfig
        , layoutHook = smartBorders (avoidStruts  $  layoutHook defaultConfig)
        , borderWidth = 2
        , modMask = mod4Mask
        , terminal = "terminator"
        } `additionalKeysP` myKeysP

myKeysP = [ ("<XF86MonBrightnessUp>",   spawn "~/bin/brightness +")
          , ("<XF86MonBrightnessDown>", spawn "~/bin/brightness -")
          , ("<XF86AudioLowerVolume>",  spawn "~/bin/volume -")
          , ("<XF86AudioRaiseVolume>",  spawn "~/bin/volume +")
          , ("<XF86AudioMute>",         spawn "~/bin/volume m")
          , ("M-<F1>",                  spawn "terminator")
          , ("M-<F2>",                  spawn "gmrun")
          , ("M-<F3>",                  spawn "xterm")
          , ("M-<F4>",                  kill)
          , ("<Print>",                 spawn "scrot")
          ]


--main = xmonad =<< myBar myPP toggleStrutsKey myConfig
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig


--myBar = xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmonad/xmobarrc"
myBar = "xmobar ~/.xmonad/xmobarrc"

--myPP = xmobarPP {ppOutput = hPutStrLn xmproc, ppTitle = xmobarColor "green" "" . shorten 50 }
myPP = xmobarPP { ppCurrent = xmobarColor "green" "" . wrap "<" ">" . shorten 68}

-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)
