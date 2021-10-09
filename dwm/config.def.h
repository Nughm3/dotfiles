/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int gappx     = 10;       /* gap pixel between windows */
static const unsigned int snap      = 0;        /* snap pixel */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        = 1;     /* 0 means no systray */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "JetBrainsMono Nerd Font:size=11" };
static const char dmenufont[]       = "JetBrainsMono Nerd Font:size=11";
/* One Dark */
static const char col_gray1[]       = "#282c34";
static const char col_gray2[]       = "#353b45";
static const char col_gray3[]       = "#e06c75";
static const char col_gray4[]       = "#c8ccd4";
static const char col_cyan[]        = "#61afef";
static const char *colors[][3]      = {
	/*                   fg         bg         border   */
	[SchemeNorm]     = { col_gray4, col_gray1, col_gray1 },
	[SchemeSel]      = { col_cyan,  col_gray1, col_cyan  },
	[SchemeTagsSel]  = { col_cyan,  col_gray1, col_cyan  }, // Tagbar left selected
    [SchemeTagsNorm] = { col_gray4, col_gray1, col_cyan  }, // Tagbar left unselected
    [SchemeInfoSel]  = { col_cyan,  col_gray1, col_cyan  }, // Infobar middle selected
    [SchemeInfoNorm] = { col_gray4, col_gray1, col_cyan  }, // Infobar middle unselected
    [SchemeStatus]   = { col_gray3, col_gray1, col_cyan  }, // Statusbar right
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     iscentered   isfloating   monitor */
    { "Gimp",     NULL,       NULL,       0,            1,           1,           -1 },
	{ "Firefox",  NULL,       NULL,       0,            0,           0,           -1 },
	{ "trayer",   NULL,       NULL,       0,            0,           1,           -1 },
};

/* layout(s) */
static const float mfact     = 0.50; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "TTT",      bstack },
	{ "===",      bstackhoriz },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }
#include <X11/XF86keysym.h>

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", NULL };
static const char *termcmd[]  = { "kitty", "-e", "fish" };
static const char *browser[]  = { "chromium", NULL };

#include "movestack.c"
static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY|ShiftMask,             XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_v,      spawn,          SHCMD("kitty -e nvim") },
	{ MODKEY|ShiftMask,             XK_v,      spawn,          SHCMD("code-insiders") },
    { Mod1Mask,                     XK_space,  spawn,          SHCMD("rofi -show combi") },
    { MODKEY,                       XK_b,      spawn,          {.v = browser } },
    { MODKEY|ShiftMask,             XK_b,      spawn,          SHCMD("chromium -incognito" ) },
    { MODKEY,                       XK_z,      spawn,          SHCMD("zathura") },
    { MODKEY,                       XK_f,      spawn,          SHCMD("thunar") },
    { MODKEY|ShiftMask,             XK_d,      spawn,          SHCMD("discord") },
    { MODKEY|ShiftMask,             XK_q,      spawn,          SHCMD("dunstify lol 'you suck aaden' && mpv /home/toxicfs/Videos/Science_of_Wellbeing.mkv") },
    /* { MODKEY,                       XK_F10,    spawn,          SHCMD("pamixer -t && notify-send 'Volume Toggled' 'Muted: $(pamixer --get-mute)'") }, */
    /* { MODKEY,                       XK_F11,    spawn,          SHCMD("pamixer -d 5 && notify-send 'Volume Decreased' 'Volume: $(pamixer --get-volume)'") }, */
    /* { MODKEY,                       XK_F12,    spawn,          SHCMD("pamixer -i 5 && notify-send 'Volume Increased' 'Volume: $(pamixer --get-volume)'") }, */
    /* Implemented in sxhkd */
    /* { Mod1Mask|ShiftMask,           XK_c,      spawn,          SHCMD("rofi -show calc -modi calc -no-show-match -no-sort") }, */
    /* { Mod1Mask|ShiftMask,           XK_f,      spawn,          SHCMD("fd . $HOME | rofi -keep-right -dmenu -i -p FILES -multi-select | xargs -I {} xdg-open {}") }, */
    /* { Mod1Mask|ShiftMask,           XK_s,      spawn,          SHCMD("dm-websearch") }, */
    /* { Mod1Mask|ShiftMask,           XK_e,      spawn,          SHCMD("dm-confedit") }, */
    /* { Mod1Mask|ShiftMask,           XK_m,      spawn,          SHCMD("dm-man") }, */
    /* { Mod1Mask|ShiftMask,           XK_k,      spawn,          SHCMD("dm-kill") }, */
    { MODKEY,                       XK_q,      spawn,          SHCMD("dm-logout") },
    { MODKEY,                       XF86XK_Launch1,            spawn,          SHCMD("dm-logout") },
    /* { 0,                            XF86XK_AudioMute,          spawn,          SHCMD("pamixer -t && notify-send 'Volume Toggled' 'Muted: $(pamixer --get-mute)'") }, */
    /* { 0,                            XF86XK_AudioLowerVolume,   spawn,          SHCMD("pamixer -d 5 && notify-send 'Volume Decreased' 'Volume: $(pamixer --get-volume)'") }, */
    /* { 0,                            XF86XK_AudioRaiseVolume,   spawn,          SHCMD("pamixer -i 5 && notify-send 'Volume Increased' 'Volume: $(pamixer --get-volume)'") }, */
    /* { ShiftMask,                    XF86XK_AudioLowerVolume,   spawn,          SHCMD("brightnessctl s 10%- && notify-send 'Brightness Decreased'") }, */
    /* { ShiftMask,                    XF86XK_AudioRaiseVolume,   spawn,          SHCMD("brightnessctl s +10% && notify-send 'Brightness Increased'") }, */
    /* { ShiftMask,                    XF86XK_AudioLowerVolume,   spawn,          SHCMD("brightnessctl s 10%- && notify-send 'Brightness Decreased'") }, */
    /* { ShiftMask,                    XF86XK_AudioRaiseVolume,   spawn,          SHCMD("brightnessctl s +10% && notify-send 'Brightness Increased'") }, */
    { 0,                            XK_Print,  spawn,          SHCMD("maim -s --hidecursor | xclip -selection clipboard -t image/png -i && notify-send 'Screenshot captured' 'Screenshot of region captured to clipboard'") },
    { ShiftMask,                    XK_Print,  spawn,          SHCMD("maim --hidecursor | xclip -selection clipboard -t image/png -i && notify-send 'Screenshot captured' 'Screenshot of region captured to clipboard'") },
    { ControlMask,                  XK_Print,  spawn,          SHCMD("dm-maim") },
    { MODKEY|Mod1Mask,              XK_p,      spawn,          SHCMD("gpick -p") },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_Up,     incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_Down,   incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_j,      movestack,      {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_k,      movestack,      {.i = -1 } },
	{ MODKEY|Mod1Mask,              XK_j,      setcfact,       {.f = +0.25} },
	{ MODKEY|Mod1Mask,              XK_k,      setcfact,       {.f = -0.25} },
	{ MODKEY|ShiftMask,             XK_o,      setcfact,       {.f =  0.00} },
	{ MODKEY,                       XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_BackSpace,              zoom,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY|ShiftMask,             XK_f,      togglefloating, {0} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  togglefullscr,  {0} },
	{ MODKEY|ShiftMask,             XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_0,      view,           {.ui = ~0 } },
	{ MODKEY,                       XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_bracketleft,            viewtoleft,     {0} },
	{ MODKEY,                       XK_bracketright,           viewtoright,    {0} },
	{ MODKEY|ShiftMask,             XK_bracketleft,            tagtoleft,      {0} },
	{ MODKEY|ShiftMask,             XK_bracketright,           tagtoright,     {0} },
	{ MODKEY,                       XK_Tab,    layoutscroll,   {.i = +1 } },
    { MODKEY|ShiftMask,             XK_Tab,    layoutscroll,   {.i = -1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	/* { MODKEY|ShiftMask,             XK_q,      quit,           {0} }, */
	{ MODKEY|ShiftMask,             XK_r,      quit,           {1} }, 
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

