import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig(additionalKeysP)
import XMonad.Layout.NoBorders(smartBorders)
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Spacing

myKeysP = [ ("<XF86MonBrightnessUp>",   spawn "~/bin/brightness +")
          , ("<XF86MonBrightnessDown>", spawn "~/bin/brightness -")
          , ("<XF86AudioLowerVolume>",  spawn "~/bin/volume -")
          , ("<XF86AudioRaiseVolume>",  spawn "~/bin/volume +")
          , ("<XF86AudioMute>",         spawn "~/bin/volume m")
          , ("M-<F1>",                  spawn "terminator")
          , ("M-<F2>",                  spawn "gmrun")
          , ("M-<F3>",                  spawn "xterm")
          , ("M-<F4>",                  kill)
          , ("M-<F7>",         spawn "~/bin/volume -")
          , ("M-<F8>",         spawn "~/bin/volume +")
          , ("M-<F9>",         spawn "~/bin/volume m")
          , ("<Print>",                 spawn "scrot")
          ]

-- Command to launch the bar.
myBar = "xmobar ~/.xmonad/xmobarrc"

-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "[" "]" }

-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

-- Main configuration, override the defaults to your liking.
myConfig = defaultConfig
        { manageHook = ( isFullscreen --> doFullFloat ) <+> manageDocks <+> manageHook defaultConfig
        , layoutHook = smartSpacing 5 $ smartBorders (avoidStruts  $  layoutHook defaultConfig)
        , borderWidth = 0
        , terminal = "terminator"
        , focusedBorderColor = "#ff4747"
        , focusFollowsMouse = False
        , normalBorderColor = "#DDDDDD"
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        } `additionalKeysP` myKeysP

-- The main function.
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

