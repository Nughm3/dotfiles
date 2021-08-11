import XMonad
import System.Directory
import System.IO (hPutStrLn)
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W

import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.CycleWS (Direction1D(..), moveTo, shiftTo, WSType(..), nextScreen, prevScreen, nextWS, prevWS)
import XMonad.Actions.GridSelect
import XMonad.Actions.MouseResize
import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves (rotSlavesDown, rotAllDown)
import XMonad.Actions.WindowGo (runOrRaise)
import XMonad.Actions.WithAll (sinkAll, killAll)
import qualified XMonad.Actions.Search as S

import Data.Char (isSpace, toUpper)
import Data.Maybe (fromJust)
import Data.Monoid
import Data.Maybe (isJust)
import Data.Tree
import qualified Data.Map as M

import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks (avoidStruts, docksEventHook, manageDocks, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat, doCenterFloat)
import XMonad.Hooks.ServerMode
import XMonad.Hooks.SetWMName
import XMonad.Hooks.WorkspaceHistory

import XMonad.Layout.SimplestFloat
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed

import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.Magnifier
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.Simplest
import XMonad.Layout.Spacing
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import XMonad.Layout.WindowNavigation
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))

import XMonad.Prompt
import XMonad.Prompt.ConfirmPrompt
import XMonad.Prompt.Input
import XMonad.Prompt.FuzzyMatch
import XMonad.Prompt.Man
import XMonad.Prompt.Shell
import XMonad.Prompt.Ssh
import XMonad.Prompt.Unicode
import XMonad.Prompt.XMonad
import Control.Arrow (first)

import XMonad.Util.Dmenu
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Util.SpawnOnce

myFont :: String
myFont = "xft:JetBrainsMono Nerd Font:regular:size=11:antialias=true:hinting=true"

myModMask :: KeyMask
myModMask = mod4Mask

myTerminal :: String
myTerminal = "kitty"

myBrowser :: String
myBrowser = "firefox "

myEditor :: String
myEditor = myTerminal ++ " -e nvim "

myBorderWidth :: Dimension
myBorderWidth = 2

myNormColor :: String
myNormColor   = "#282C34"

myFocusColor :: String
myFocusColor  = "#61AFEF"

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

myStartupHook :: X ()
myStartupHook = do
    spawnOnce "xrandr --output HDMI-1 --same-as eDP-1"
    spawnOnce "nitrogen --restore &"
    spawnOnce "trayer --edge top --align right --widthtype pixel --padding 6 --SetDockType true --SetPartialStrut true --expand false --monitor 1 --transparent true --alpha 0 --tint 0x282c34  --height 22 --distancefrom right --width 100 --distance 17 &"
    spawnOnce "picom &"
    spawnOnce "lxsession &"
    spawnOnce "thunar --daemon &"
    spawnOnce "noisetorch -t 95 -i"
    setWMName "xmonad"

myColorizer :: Window -> Bool -> X (String, String)
myColorizer = colorRangeFromClassName
                  (0x28,0x2c,0x34) -- lowest inactive bg
                  (0x28,0x2c,0x34) -- highest inactive bg
                  (0xc7,0x92,0xea) -- active bg
                  (0xc0,0xa7,0x9a) -- inactive fg
                  (0x28,0x2c,0x34) -- active fg

-- gridSelect menu layout
mygridConfig :: p -> GSConfig Window
mygridConfig colorizer = (buildDefaultGSConfig myColorizer)
    { gs_cellheight   = 40
    , gs_cellwidth    = 200
    , gs_cellpadding  = 6
    , gs_originFractX = 0.5
    , gs_originFractY = 0.5
    , gs_font         = myFont
    }

spawnSelected' :: [(String, String)] -> X ()
spawnSelected' lst = gridselect conf lst >>= flip whenJust spawn
    where conf = def
                   { gs_cellheight   = 40
                   , gs_cellwidth    = 200
                   , gs_cellpadding  = 6
                   , gs_originFractX = 0.5
                   , gs_originFractY = 0.5
                   , gs_font         = myFont
                   }

myAppGrid = [ ("Firefox", "firefox")
                 , ("GIMP", "gimp")
                 , ("Neovim", "kitty -e nvim")
                 , ("Thunar", "thunar")
                 , ("Tenacity", "tenacity")
                 , ("Inkscape", "inkscape")
                 , ("VS Code", "code-insiders")
                 , ("LibreOffice", "libreoffice")
                 , ("LibreOffice Writer", "lowriter")
                 , ("Aseprite", "aseprite")
                 , ("OBS", "obs")
                 , ("Blender", "blender")
                 , ("Resolve", "resolve")
                 ]

myPowerGrid = [ ("Cancel", "echo 0")
                    , ("Shutdown", "poweroff")
                    , ("Suspend", "systemctl suspend")
                    , ("Restart", "reboot")
                    , ("Lock", "light-locker-command -l")
                    ]

myCompositorGrid = [ ("Config", "nvim ~/.config/picom/picom.conf")
                    , ("Animations OFF", "dunstify TODO") 
                    , ("Animations ON", "dunstify TODO") 
                    ]

myXmonadGrid = [ ("Cancel", "echo 0")
                    , ("Restart", "xmonad --recompile && xmonad --restart")
                    , ("Xmobar", myEditor ++ "~/.xmobarrc")
                    , ("Config", myEditor ++ "~/.xmonad/xmonad.hs")
                    , ("Docs", myBrowser ++ "https://xmonad.org/documentation.html")
                    ]

myOfficeGrid = [ ("LibreOffice", "libreoffice")
                    , ("Writer", "lowriter")
                    , ("Impress", "loimpress")
                    , ("Calc", "localc")
                    , ("Draw", "lodraw")
                    , ("Base", "lobase")
                    , ("Math", "lomath")
                    ]

mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

mySpacing' :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing' i = spacingRaw True (Border i i i i) True (Border i i i i) True

tall     = renamed [Replace "tall"]
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 12
           $ mySpacing 6
           $ ResizableTall 1 (3/100) (1/2) []
-- magnify  = renamed [Replace "magnify"]
--            $ smartBorders
--            $ windowNavigation
--            $ addTabs shrinkText myTabTheme
--            $ subLayout [] (smartBorders Simplest)
--            $ magnifier
--            $ limitWindows 12
--            $ mySpacing 6
--            $ ResizableTall 1 (3/100) (1/2) []
monocle  = renamed [Replace "monocle"]
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 20 Full
floats   = renamed [Replace "floats"]
           $ smartBorders
           $ limitWindows 20 simplestFloat
tabs     = renamed [Replace "tabs"]
           $ tabbed shrinkText myTabTheme

myTabTheme = def { fontName            = myFont
                 , activeColor         = "#61afef"
                 , inactiveColor       = "#282c34"
                 , activeBorderColor   = "#61afef"
                 , inactiveBorderColor = "#282c34"
                 , activeTextColor     = "#282c34"
                 , inactiveTextColor   = "#61afef"
                 }

-- The layout hook
myLayoutHook = avoidStruts $ mouseResize $ windowArrange $ T.toggleLayouts floats
               $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
             where
               myDefaultLayout =     withBorder myBorderWidth tall
                                 -- ||| magnify
                                 ||| noBorders monocle
                                 ||| floats
                                 ||| noBorders tabs

myWorkspaces = [" 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 "]
-- myWorkspaces = [" dev ", " www ", " sys ", " doc ", " vbox ", " chat ", " mus ", " vid ", " gfx "]
myWorkspaceIndices = M.fromList $ zip myWorkspaces [1..] -- (,) == \x y -> (x,y)

clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
    where i = fromJust $ M.lookup ws myWorkspaceIndices

myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll
     -- 'doFloat' forces a window to float.  Useful for dialog boxes and such.
     -- using 'doShift ( myWorkspaces !! 7)' sends program to workspace 8!
     [ className =? "confirm"         --> doFloat
     , className =? "file_progress"   --> doFloat
     , className =? "dialog"          --> doFloat
     , className =? "download"        --> doFloat
     , className =? "error"           --> doFloat
     , className =? "Gimp"            --> doFloat
     , className =? "notification"    --> doFloat
     , className =? "pinentry-gtk-2"  --> doFloat
     , className =? "splash"          --> doFloat
     , className =? "toolbar"         --> doFloat
     , className =? "Yad"             --> doCenterFloat
     , (className =? "firefox" <&&> resource =? "Dialog") --> doFloat  -- Float Firefox Dialog
     , isFullscreen -->  doFullFloat
     ]

myKeys :: [(String, X ())]
myKeys =
    -- Xmonad
        [ ("M-S-r", spawn "xmonad --recompile" >> spawn "xmonad --restart")    -- Restarts xmonad
        , ("M-r", spawnSelected' myXmonadGrid)
        , ("M-S-q", io exitSuccess)              -- Quits xmonad

    -- Run Prompt
        , ("M1-<Space>", spawn "rofi -show combi")
        , ("M-S-c", spawn "rofi -show calc -modi calc -no-show-match -no-sort")
        , ("M-s", spawn "rofi-surfraw")
        , ("M-S-f", spawn "fd . $HOME | rofi -keep-right -dmenu -i -p FILES -multi-select | xargs -I {} xdg-open {}")
        , ("M-p f", spawn "fd . $HOME | rofi -keep-right -dmenu -i -p FILES -multi-select | xargs -I {} xdg-open {}")
        , ("M-p c", spawn "rofi -show calc -modi calc -no-show-match -no-sort")
        , ("M-p e", spawn "dm-confedit")  -- edit config files
        , ("M-p k", spawn "dm-kill")      -- kill processes
        , ("M-p m", spawn "dm-man")       -- manpages
        , ("M-p q", spawn "dm-logout")    -- logout menu
        , ("M-p s", spawn "dm-websearch") -- search various search engines

    -- Useful programs to have a keybinding for launch
        , ("M-<Return>", spawn myTerminal)
        , ("M-b", spawn myBrowser)
        , ("M-S-b", spawn "firefox --private-window")
        , ("M-f", spawn "thunar")
        , ("M-v", spawn myEditor)
        , ("M-S-d", spawn "discord")
        , ("C-M1-<Delete>", spawn (myTerminal ++ " -e htop")) -- just in case a windows user comes along

    -- Kill windows
        , ("M-c", kill1)     -- Kill the currently focused client
        , ("M-M1-S-c", killAll)   -- Kill all windows on current workspace

    -- Workspaces
        , ("M-.", nextWS)
        , ("M-,", prevWS)
        , ("M-]", nextWS)
        , ("M-[", prevWS)
        , ("M-S-<KP_Add>", shiftTo Next nonNSP >> moveTo Next nonNSP)       -- Shifts focused window to next ws
        , ("M-S-<KP_Subtract>", shiftTo Prev nonNSP >> moveTo Prev nonNSP)  -- Shifts focused window to prev ws

    -- Re-tiling windows
        , ("M-t", withFocused $ windows . W.sink)  -- Push floating window back to tile
        , ("M-S-t", sinkAll)                       -- Push ALL floating windows to tile

    -- Increase/decrease spacing (gaps)
        , ("C-M-j", decWindowSpacing 2 >> decScreenSpacing 2)         -- Decrease window spacing
        , ("C-M-k", incWindowSpacing 2 >> incScreenSpacing 2)         -- Increase window spacing

    -- Grid Select (CTR-g followed by a key)
        , ("M-g", spawnSelected' myAppGrid)                 -- grid select favorite apps
        , ("M-q", spawnSelected' myPowerGrid)
        , ("M-o", spawnSelected' myOfficeGrid)

    -- Windows navigation
        , ("M-m", windows W.focusMaster)  -- Move focus to the master window
        , ("M-j", windows W.focusDown)    -- Move focus to the next window
        , ("M-k", windows W.focusUp)      -- Move focus to the prev window
        , ("M-S-m", windows W.swapMaster) -- Swap the focused window and the master window
        , ("M-S-<Return>", windows W.swapMaster) -- Swap the focused window and the master window
        , ("M-S-j", windows W.swapDown)   -- Swap focused window with next window
        , ("M-S-k", windows W.swapUp)     -- Swap focused window with prev window
        , ("M-<Backspace>", promote)      -- Moves focused window to master, others maintain order
        -- , ("M-S-<Tab>", rotSlavesDown)    -- Rotate all windows except master and keep focus in place
        , ("M-C-<Tab>", rotAllDown)       -- Rotate all the windows in the current stack
        , ("M1-<Tab>", windows W.focusDown)
        , ("M1-S-<Tab>", windows W.focusUp)

    -- Layouts
        , ("M-<Tab>", sendMessage NextLayout)
        , ("M-S-<Tab>", sendMessage FirstLayout)
        , ("M-<Space>", sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts) -- Toggles noborder/full

    -- Increase/decrease windows in the master pane or the stack
        , ("M-S-<Up>", sendMessage (IncMasterN 1))      -- Increase # of clients master pane
        , ("M-S-<Down>", sendMessage (IncMasterN (-1))) -- Decrease # of clients master pane

    -- Window resizing
        , ("M-h", sendMessage Shrink)                   -- Shrink horiz window width
        , ("M-l", sendMessage Expand)                   -- Expand horiz window width
        , ("M-M1-j", sendMessage MirrorShrink)          -- Shrink vert window width
        , ("M-M1-k", sendMessage MirrorExpand)          -- Expand vert window width

    -- Multimedia Keys
        , ("<XF86AudioMute>", spawn "amixer set Master toggle")
        , ("<XF86AudioLowerVolume>", spawn "amixer set Master 5%- unmute")
        , ("<XF86AudioRaiseVolume>", spawn "amixer set Master 5%+ unmute")
        , ("M-<F10>", spawn "amixer set Master toggle")
        , ("M-<F11>", spawn "amixer set Master 5%- unmute")
        , ("M-<F12>", spawn "amixer set Master 5%+ unmute")
        , ("S-<XF86AudioLowerVolume>", spawn "brightnessctl s 10%-")
        , ("S-<XF86AudioRaiseVolume>", spawn "brightnessctl s 10%+")
        , ("<Print>", spawn "maim -s | xclip -selection clipboard -t image/png")
        , ("C-<Print>", spawn "maim | xclip -selection clipboard -t image/png")
        ]
        where nonNSP          = WSIs (return (\ws -> W.tag ws /= "NSP"))
              nonEmptyNonNSP  = WSIs (return (\ws -> isJust (W.stack ws) && W.tag ws /= "NSP"))

main :: IO ()
main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ ewmh def
        { manageHook         = myManageHook <+> manageDocks
        , handleEventHook    = docksEventHook
                               <+> fullscreenEventHook                          -- Uncomment this line to enable fullscreen support on things like YouTube/Netflix.
        , modMask            = myModMask
        , terminal           = myTerminal
        , startupHook        = myStartupHook
        , layoutHook         = myLayoutHook
        , workspaces         = myWorkspaces
        , borderWidth        = myBorderWidth
        , normalBorderColor  = myNormColor
        , focusedBorderColor = myFocusColor
        , logHook = dynamicLogWithPP $ xmobarPP
              -- the following variables beginning with 'pp' are settings for xmobar.
              { ppOutput = \x -> hPutStrLn xmproc x                           -- xmobar on monitor 1
              , ppCurrent = xmobarColor "#e06c75" "" . wrap "[" "]"         -- Current workspace
              , ppVisible = xmobarColor "#e06c75" "" . clickable              -- Visible but not current workspace
              , ppHidden = xmobarColor "#e5c07b" "" . clickable -- Hidden workspaces
              , ppHiddenNoWindows = xmobarColor "#61afef" ""  . clickable     -- Hidden workspaces (no windows)
              , ppTitle = xmobarColor "#abb2bf" "" . shorten 60               -- Title of active window
              , ppSep =  "<fc=#565c64> <fn=1>|</fn> </fc>"                    -- Separator character
              , ppUrgent = xmobarColor "#e06c75" "" . clickable -- Urgent workspace
              , ppExtras = [windowCount]
              , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]                    -- order of things in xmobar
              }
        } `additionalKeysP` myKeys
