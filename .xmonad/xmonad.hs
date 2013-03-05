import qualified Data.Map as M
import Data.Monoid

import XMonad
import qualified XMonad.StackSet as W

import XMonad.Config.Xfce
import XMonad.Hooks.ICCCMFocus
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.NoBorders
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Actions.CycleWS(nextScreen, swapNextScreen)

main = xmonad xfceConfig
    { modMask = mod4Mask
    , manageHook = manageDocks
        <+> composeAll
            [ isFullscreen --> doFullFloat
            , className =? "Xfce4-notifyd" --> doIgnore
            , isInProperty "_NET_WM_WINDOW_TYPE" "_NET_WM_WINDOW_TYPE_MENU" --> doFloat
            ]
        <+> manageHook defaultConfig
    , keys = \c -> keys' c `M.union` keys xfceConfig c
    , layoutHook = smartBorders $ layoutHook xfceConfig
    }

keys' conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, xK_q), kill)
    , ((modm .|. shiftMask, xK_c), spawn "xmonad --recompile && xmonad --restart")
    , ((modm .|. shiftMask, xK_Return), spawn "xfce4-terminal")
    , ((modm, xK_r), spawn "xflock4")
    -- xinerama movements
    , ((modm, xK_w), nextScreen)
    , ((modm, xK_e), swapNextScreen)
    -- restore defaults
    , ((modm, xK_p), spawn "dmenu_run")
    -- media keys
    , ((modm, xK_bracketright), spawn "/home/rraval/bin/rdio next")
    , ((modm, xK_bracketleft), spawn "/home/rraval/bin/rdio prev")
    , ((modm, xK_backslash), spawn "/home/rraval/bin/rdio playpause")
    ]
