import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.NoBorders
import XMonad.Layout.Gaps
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import Graphics.X11.ExtraTypes.XF86
import System.IO

main = do
  xmproc <- spawnPipe "/usr/bin/xmobar /home/cmaureir/.xmonad/xmobarrc"
  xmonad $ defaultConfig {
    modMask = mod4Mask,
    terminal = "urxvt",
    manageHook = manageDocks <+> manageHook defaultConfig,
    layoutHook = avoidStruts $ layoutHook defaultConfig,
    logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc,
                          ppTitle = xmobarColor "green" "" . shorten 50
                        }
  }`additionalKeys`
      [(( mod4Mask, xK_F1), spawn "urxvt") -- to open firefox
      , (( mod4Mask, xK_F4), kill) -- to kill applications
      ,(( controlMask, xK_KP_Add), sendMessage Expand) -- Ctrl + the plus (+) button to expand the master pane
      , ((0, xK_Print), spawn "scrot") -- use the print key to capture screenshot with scrot
      , ((0, xF86XK_AudioLowerVolume   ), pawn "amixer set Master 2-")
      , ((0, xF86XK_AudioRaiseVolume   ), spawn "amixer set Master 2+")
      , ((0, xF86XK_AudioMute          ), spawn "amixer set Master toggle")
      ]
