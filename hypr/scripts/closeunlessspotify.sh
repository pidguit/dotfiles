active_win=$(hyprctl activewindow | sed -n '6p' | awk '{print $2}')

if [ "-98" == "$active_win" ]; then 
    exit 0

else
    hyprctl dispatch closewindow activewindow 
fi
