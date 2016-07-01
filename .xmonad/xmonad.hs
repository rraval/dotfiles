{-# LANGUAGE OverloadedStrings #-}

import qualified Data.Map as M
import Data.Monoid

import XMonad
import qualified XMonad.StackSet as W

import XMonad.Actions.CycleWS(nextScreen, swapNextScreen)
import XMonad.Actions.Navigation2D
import XMonad.Config.Xfce
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ICCCMFocus
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Util.EZConfig(additionalKeys)

import qualified DBus as D
import qualified DBus.Client as D
import qualified Codec.Binary.UTF8.String as UTF8

main = do
    dbus <- D.connectSession
    getWellKnownName dbus
    xmonad xfceConfig
        { modMask = mod4Mask
        , startupHook = startupHook xfceConfig >> setWMName "LG3D"
        , manageHook = manageDocks
            <+> composeAll
                [ isFullscreen --> doFullFloat
                , className =? "Xfce4-notifyd" --> doIgnore
                , className =? "Zeal" --> doFullFloat
                , isInProperty "_NET_WM_WINDOW_TYPE" "_NET_WM_WINDOW_TYPE_MENU" --> doFloat
                ]
            <+> manageHook defaultConfig
        , keys = \c -> keys' c `M.union` keys xfceConfig c
        , layoutHook = (smartBorders $ layoutHook xfceConfig) ||| (noBorders $ fullscreenFull Full)
        , logHook = do
            logHook xfceConfig
            dynamicLogWithPP (prettyPrinter dbus)
        }

keys' conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, xK_q), kill)
    , ((modm .|. shiftMask, xK_c), spawn "xmonad --recompile && xmonad --restart")
    , ((modm .|. shiftMask, xK_Return), spawn "xfce4-terminal")
    , ((modm, xK_r), spawn "xflock4")
    -- xinerama movements
    , ((modm, xK_w), nextScreen)
    , ((modm, xK_e), swapNextScreen)
    -- 2D navigation
    , ((modm, xK_h), windowGo L True)
    , ((modm, xK_j), windowGo D True)
    , ((modm, xK_k), windowGo U True)
    , ((modm, xK_l), windowGo R True)
    -- shrink & expand master pane
    , ((modm, xK_m), sendMessage Expand)
    , ((modm, xK_n), sendMessage Shrink)
    -- restore defaults
    , ((modm, xK_p), spawn "dmenu_run")
    -- media keys
    , ((modm, xK_bracketright), spawn "nuvolaplayer3ctl action next-song")
    , ((modm, xK_bracketleft), spawn "nuvolaplayer3ctl action prev-song")
    , ((modm, xK_backslash), spawn "nuvolaplayer3ctl action toggle-play")
    , ((modm, xK_equal), spawn "nuvolaplayer3ctl action thumbs-up")
    , ((modm, xK_minus), spawn "nuvolaplayer3ctl action thumbs-down")
    ]

prettyPrinter :: D.Client -> PP
prettyPrinter dbus = defaultPP
    { ppOutput   = dbusOutput dbus
    , ppTitle    = pangoSanitize
    , ppCurrent  = pangoColor "#204a87" . wrap "[" "]" . pangoSanitize
    , ppVisible  = pangoColor "#ce5c00" . wrap "(" ")" . pangoSanitize
    , ppHidden   = pangoColor "#8f5902" . pangoSanitize
    , ppUrgent   = pangoColor "#a40000" . pangoSanitize
    , ppLayout   = pangoColor "#4e9a06" . wrap "{" "}" . pangoSanitize
    , ppSep      = " "
    }

getWellKnownName :: D.Client -> IO ()
getWellKnownName dbus = do
  D.requestName dbus (D.busName_ "org.xmonad.Log")
                [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]
  return ()

dbusOutput :: D.Client -> String -> IO ()
dbusOutput dbus str = do
    let signal = (D.signal "/org/xmonad/Log" "org.xmonad.Log" "Update") {
            D.signalBody = [D.toVariant ("<b>" ++ (UTF8.decodeString str) ++ "</b>")]
        }
    D.emit dbus signal

pangoColor :: String -> String -> String
pangoColor fg = wrap left right
  where
    left  = "<span foreground=\"" ++ fg ++ "\">"
    right = "</span>"

pangoSanitize :: String -> String
pangoSanitize = foldr sanitize ""
  where
    sanitize '>'  xs = "&gt;" ++ xs
    sanitize '<'  xs = "&lt;" ++ xs
    sanitize '\"' xs = "&quot;" ++ xs
    sanitize '&'  xs = "&amp;" ++ xs
    sanitize x    xs = x:xs
