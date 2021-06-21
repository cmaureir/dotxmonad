import XMonad
import qualified Codec.Binary.UTF8.String as UTF8
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig(additionalKeysP)
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.NoBorders(smartBorders)
import XMonad.Layout.Spacing
import XMonad.Layout.SimplestFloat
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Tabbed
import XMonad.StackSet (RationalRect (..), currentTag)

myKeysP = [
      ("<XF86AudioLowerVolume>",  spawn "~/bin/volume -")
    , ("<XF86AudioRaiseVolume>",  spawn "~/bin/volume +")
    , ("<XF86AudioMute>",         spawn "~/bin/volume m")
    , ("<XF86AudioNext>",         spawn "~/bin/player next")
    , ("<XF86AudioPrev>",         spawn "~/bin/player prev")
    , ("<XF86AudioPlay>",         spawn "~/bin/player play")
    , ("<XF86AudioPause>",        spawn "~/bin/player pause")
    , ("<XF86AudioStop>",         spawn "~/bin/player stop")
    , ("M-<F1>",                  spawn "konsole")
    , ("M-<Esc>",                 spawn "konsole")
    , ("M-<F2>",                  spawn "~/bin/run")
    , ("M-<F3>",                  spawn "kitty")
    , ("M-<F4>",                  kill)
    , ("M-<F7>",                  spawn "~/bin/volume -")
    , ("M-<F8>",                  spawn "~/bin/volume +")
    , ("M-<F9>",                  spawn "~/bin/volume m")
    , ("<Print>",                 spawn "scrot")
    ]

myWorkspaces = map show [1..9]

-- Command to launch the bar.
myBar = "xmobar -x 1 ~/.xmonad/xmobarrc"

-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP = xmobarPP {
    ppTitle = (\str -> "")
    , ppCurrent = xmobarColor "#778eca" "" . wrap "[" "]"
    , ppOrder = \(ws:l:t:_)   -> [ws]
}

-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

tabConfig = defaultTheme {
    activeBorderColor = "#7C7C7C",
    activeTextColor = "#CEFFAC",
    activeColor = "#000000",
    inactiveBorderColor = "#7C7C7C",
    inactiveTextColor = "#EEEEEE",
    inactiveColor = "#000000"
}

-- Main configuration, override the defaults to your liking.
myConfig = defaultConfig
    { manageHook = ( isFullscreen --> doFullFloat ) <+> manageDocks <+> manageHook defaultConfig <+> (onFloatingWorkSpace --> doFloat)
    , workspaces = myWorkspaces
    , layoutHook = smartSpacing 5 $ onWorkspace "8" simplestFloat $ smartBorders (avoidStruts  $  layoutHook defaultConfig)
    , borderWidth = 0
    , terminal = "terminator"
    , focusedBorderColor = "#ff4747"
    , focusFollowsMouse = False
    , normalBorderColor = "#DDDDDD"
    , modMask = mod4Mask
} `additionalKeysP` myKeysP

onFloatingWorkSpace :: Query Bool
onFloatingWorkSpace = liftX $
    withWindowSet (return . (`elem` floating) . currentTag)
  where
    floating = ["8"]

-- The main function.
main :: IO ()
main = do
    xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig
