#!/bin/bash

# Color Variables
CYAN="\033[0;36m"
NC="\033[0m" # No Color
INFO="\033[0;32m"
ERROR="\033[0;31m"
SUCCESS="\033[0;32m"
WARN="\033[0;33m"

# Display a message after logo
echo -e "${CYAN}🎉 Displaying Basuki Preman Buronan!!! ${NC}"

# Display logo directly from URL
echo -e "${CYAN}✨ Displaying logo... ${NC}"
wget -qO- https://raw.githubusercontent.com/Chupii37/Chupii-Node/refs/heads/main/Logo.sh | bash

# Update and upgrade system packages
echo -e "${INFO}🔄 Updating and upgrading packages... ${NC}"
sudo apt update && sudo apt upgrade -y

# Check if Docker is installed
echo -e "${INFO}🔍 Checking Docker installation... ${NC}"
if ! command -v docker &> /dev/null; then
    echo -e "${ERROR}🚫 Docker not found. Installing Docker... ${NC}"
    sudo apt install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
    echo -e "${SUCCESS}✔️ Docker successfully installed! ${NC}"
else
    echo -e "${SUCCESS}✔️ Docker is already installed. ${NC}"
fi

# Clean up unnecessary packages
echo -e "${INFO}🧹 Cleaning up unnecessary packages... ${NC}"
sudo apt-get autoremove -y
sudo apt-get clean
echo -e "${SUCCESS}✅ Unnecessary packages removed! ${NC}"

# Prompt user to enter wallet address
echo -e "${CYAN}💸 Enter your wallet address: ${NC}"
read address

# Choose server pool
echo -e "${CYAN}🌐 Choose your server pool: ${NC}"
echo "a. Singapore"
echo "b. China Hong Kong"
echo "c. Asia Korea"
echo "d. Australia Sydney"
echo "e. France Gravelines"
echo "f. Germany Frankfurt"
echo "g. Ukraine Kiev"
echo "h. Finland Helsinki"
echo "i. Romania Bucharest"
echo "j. Poland Warsaw"
echo "k. Kazakhstan Almaty"
echo "l. USA (West) California"
echo "m. USA (North East) Ohio"
echo "n. Turkey Istanbul"
echo "o. USA (South East) Georgia"
echo "p. USA (South West) Texas"
echo "q. Canada Montreal"
echo "r. Russia Moscow"
echo "s. South America Brazil"
read server_choice

# Prompt user to choose mining pool or solo pool
echo -e "${CYAN}💎 Choose pool type: ${NC}"
echo "a. Mining pool"
echo "b. Solo pool"
read pool_type

# Map server choice to pool addresses based on pool type
if [[ "$pool_type" == "a" ]]; then
    case $server_choice in
        a) pool="stratum+tcp://sg.vipor.net:5077" ;;
        b) pool="stratum+tcp://cn.vipor.net:5077" ;;
        c) pool="stratum+tcp://ap.vipor.net:5077" ;;
        d) pool="stratum+tcp://au.vipor.net:5077" ;;
        e) pool="stratum+tcp://fr.vipor.net:5077" ;;
        f) pool="stratum+tcp://de.vipor.net:5077" ;;
        g) pool="stratum+tcp://ua.vipor.net:5077" ;;
        h) pool="stratum+tcp://fi.vipor.net:5077" ;;
        i) pool="stratum+tcp://ro.vipor.net:5077" ;;
        j) pool="stratum+tcp://pl.vipor.net:5077" ;;
        k) pool="stratum+tcp://kz.vipor.net:5077" ;;
        l) pool="stratum+tcp://usw.vipor.net:5077" ;;
        m) pool="stratum+tcp://us.vipor.net:5077" ;;
        n) pool="stratum+tcp://tr.vipor.net:5077" ;;
        o) pool="stratum+tcp://usse.vipor.net:5077" ;;
        p) pool="stratum+tcp://ussw.vipor.net:5077" ;;
        q) pool="stratum+tcp://ca.vipor.net:5077" ;;
        r) pool="stratum+tcp://ru.vipor.net:5077" ;;
        s) pool="stratum+tcp://sa.vipor.net:5077" ;;
        *) echo -e "${ERROR}🚫 Invalid server choice. Exiting. ${NC}" && exit 1 ;;
    esac
elif [[ "$pool_type" == "b" ]]; then
    case $server_choice in
        a) pool="stratum+tcp://sg.vipor.net:5078" ;;
        b) pool="stratum+tcp://cn.vipor.net:5078" ;;
        c) pool="stratum+tcp://ap.vipor.net:5078" ;;
        d) pool="stratum+tcp://au.vipor.net:5078" ;;
        e) pool="stratum+tcp://fr.vipor.net:5078" ;;
        f) pool="stratum+tcp://de.vipor.net:5078" ;;
        g) pool="stratum+tcp://ua.vipor.net:5078" ;;
        h) pool="stratum+tcp://fi.vipor.net:5078" ;;
        i) pool="stratum+tcp://ro.vipor.net:5078" ;;
        j) pool="stratum+tcp://pl.vipor.net:5078" ;;
        k) pool="stratum+tcp://kz.vipor.net:5078" ;;
        l) pool="stratum+tcp://usw.vipor.net:5078" ;;
        m) pool="stratum+tcp://us.vipor.net:5078" ;;
        n) pool="stratum+tcp://tr.vipor.net:5078" ;;
        o) pool="stratum+tcp://usse.vipor.net:5078" ;;
        p) pool="stratum+tcp://ussw.vipor.net:5078" ;;
        q) pool="stratum+tcp://ca.vipor.net:5078" ;;
        r) pool="stratum+tcp://ru.vipor.net:5078" ;;
        s) pool="stratum+tcp://sa.vipor.net:5078" ;;
        *) echo -e "${ERROR}🚫 Invalid server choice. Exiting. ${NC}" && exit 1 ;;
    esac
else
    echo -e "${ERROR}🚫 Invalid pool type. Exiting. ${NC}"
    exit 1
fi

# Prompt user to enter worker name
echo -e "${CYAN}🧑‍💻 Enter your worker name: ${NC}"
read worker_name

# Prompt user to enter full thread config manually
echo -e "${CYAN}⚙️ Enter your desired thread configuration (e.g., '--threads 4'): ${NC}"
read cpu_threads

wget https://github.com/doktor83/SRBMiner-Multi/releases/download/2.8.2/SRBMiner-Multi-2-8-2-Linux.tar.gz

tar -xvzf SRBMiner-Multi-2-8-2-Linux.tar.gz

chmod +x SRBMiner-Multi-2-8-2/SRBMiner-MULTI

rm SRBMiner-Multi-2-8-2-Linux.tar.gz

cd SRBMiner-Multi-2-8-2

./SRBMiner-MULTI --algorithm xelishashv2 --pool $pool --wallet $address.$worker_name --cpu-threads $cpu_threads
