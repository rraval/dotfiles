import qualified Data.Map as M

import XMonad
import XMonad.Config.Xfce
import XMonad.Hooks.ICCCMFocus
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Actions.CycleWS(nextScreen, swapNextScreen)

main = xmonad xfceConfig
    { modMask = mod4Mask
    , manageHook = manageDocks
        <+> composeAll
            [ isFullscreen --> doFullFloat
            , className =? "Xfce4-notifyd" --> doIgnore
            ]
        <+> manageHook defaultConfig
    , keys = \c -> keys' c `M.union` keys xfceConfig c
    }

keys' conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, xK_q), kill)
    , ((modm .|. shiftMask, xK_c), spawn "xmonad --recompile && xmonad --restart")
    , ((modm, xK_r), spawn "xscreensaver-command --lock")
    -- xinerama movements
    , ((modm, xK_w), nextScreen)
    , ((modm, xK_e), swapNextScreen)
    -- restore defaults
    , ((modm, xK_p), spawn "dmenu_run")
    -- media keys
    , ((modm, xK_bracketright), spawn "/home/rraval/bin/rdio next")
    , ((modm, xK_bracketleft), spawn "/home/rraval/bin/rdio prev")
    , ((modm, xK_space), spawn "/home/rraval/bin/rdio playpause")
    ]
