# Default fan curves
# CPU: enabled: false, 30c:17%,64c:30%,68c:45%,72c:53%,76c:68%,80c:91%,80c:91%,80c:91%
# GPU: enabled: false, 30c:17%,64c:30%,68c:45%,72c:53%,76c:68%,80c:94%,80c:94%,80c:94%
# MID: enabled: false, 30c:0%,64c:0%,68c:0%,72c:0%,76c:80%,80c:80%,80c:80%,80c:80%
if false && test (tty) = "/dev/tty1" && status --is-login && test (fastfetch -j | jq -r '.[] | select(.type == "Host") | .result.family') = 'ROG Zephyrus M16'
  eval echo 'Enabling less aggressive fan curves...'
  eval asusctl fan-curve -D 30c:0%,64c:0%,68c:0%,72c:53%,76c:68%,80c:91%,80c:91%,80c:91% -m Performance -f GPU
  eval asusctl fan-curve -D 30c:0%,64c:0%,68c:0%,72c:53%,76c:68%,80c:91%,80c:91%,80c:91% -m Performance -f CPU
  eval asusctl fan-curve -e true -m Performance
end
