import qualified Data.Map as M

import XMonad
import XMonad.Config.Xfce
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
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
    -- xinerama movements
    , ((modm, xK_w), nextScreen)
    , ((modm, xK_e), swapNextScreen)
    -- restore defaults
    , ((modm, xK_p), spawn "dmenu_run")
    ]
