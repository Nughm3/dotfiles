#!/usr/bin/env bash

export BEMENU_OPTS="-i -p run --fn 'JetBrainsMono Nerd Font 11' -H 30 --ch 16 --cw 2 --hp 8 --tb '#61afef' --tf '#282c34' --ff '#c8ccd4' --fb '#1e222a' --nb '#282c34' --nf '#61afef' --hb '#61afef' --hf '#282c34' --ab '#282c34' --af '#61afef'"

display_main_menu() {
    chosen_option=$(echo -e "$1" | bemenu -i -p "Timewarrior")
    case $chosen_option in
        "Quick start")
            timew start
            notify-send "Timewarrior" "Time tracking started."
            ;;
        "Start (tags)")
            tags=$(echo "" | bemenu -p "Tags:")
            timew start $tags
            notify-send "Timewarrior" "Time tracking started with tags: $tags"
            ;;
        "Start (tags, options)")
            tags=$(echo "" | bemenu -p "Tags:")
            options=$(echo "" | bemenu -p "Options:")
            timew start $tags $options
            notify-send "Timewarrior" "Time tracking started with tags: $tags and options: $options"
            ;;
        "Stop")
            timew stop
            notify-send "Timewarrior" "Time tracking stopped."
            ;;
        "Continue")
            timew continue
            notify-send "Timewarrior" "Time tracking continued."
            ;;
        "Cancel")
            timew cancel
            notify-send "Timewarrior" "Last tracking entry canceled."
            ;;
        "Annotate")
            annotation=$(echo "" | bemenu -p "Annotation:")
            timew annotate $annotation
            notify-send "Timewarrior" "Annotation added: $annotation"
            ;;
        "Summary")
            summary=$(timew summary)
            notify-send "Timewarrior Summary" "$summary"
            ;;
        "Report")
            report_params=$(echo "" | bemenu -p "Report parameters:")
            report=$(timew $report_params)
            notify-send "Timewarrior Report" "$report"
            ;;
    esac
}

if timew | grep -q "Tracking"; then
    display_main_menu "Stop\nCancel\nAnnotate\nSummary\nReport"
else
    display_main_menu "Quick start\nContinue\nStart (tags)\nStart (tags, options)\nSummary\nReport"
fi