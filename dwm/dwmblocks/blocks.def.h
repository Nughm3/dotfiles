//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		                                /*Update Interval*/	        /*Update Signal*/
    /* {"墳  ",      "pamixer --get-volume",                         5,                          0}, */
    {"  ",   "upower -i /org/freedesktop/UPower/devices/battery_BAT0 | rg percentage | awk '{ print $2 }'",                             5,                          0},
    {"",        "upower -i /org/freedesktop/UPower/devices/battery_BAT0 | rg time | awk '{ print $4 }' | xargs",                           5,                          0},
    {"",        "upower -i /org/freedesktop/UPower/devices/battery_BAT0 | rg time | awk '{ print $5 }' | xargs",                           5,                          0},
	{"| ",      "date '+%b %d (%a) %H:%M '",	      	        5,		                    0},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " ";
static unsigned int delimLen = 5;
