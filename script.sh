echo -e "\e[1;31m$(whoami)\e[0m""@""\e[1;31m$(hostname)\e[0m"
echo "-----------"

echo -e "\e[1;36mOS:\e[0m $(lsb_release -d | awk -F'\t' '{print $2}')"
echo -e "\e[1;36mKernel:\e[0m $(uname -r)"
echo -e "\e[1;36mShell:\e[0m $SHELL"

echo -e "\e[1;36mUptime:\e[0m $(uptime -p | sed 's/up //')"
echo -e "\e[1;36mCPU Load Avg:\e[0m $(uptime | awk -F'load average: ' '{print $2}')"
cpu_model=$(lscpu | grep 'Model name:' | awk '{print $3 " " $4 " " $5 " " $6 " " $7}')
cpu_threads=$(lscpu | grep 'Thread(s) per core:' | awk '{print $4}')
echo -e "\e[1;36mCPU:\e[0m $cpu_model ($cpu_threads)"

gpu_info=$(lspci | grep '3D' | awk -F': ' '{print $2}')
echo -e "\e[1;36mGPU:\e[0m ${gpu_info}"

memory_info=$(free -h | awk '/^Mem:/ {print $3 " / " $2}')
memory_usage=$(free | awk '/^Mem:/ {print $3/$2}')
if [ $(echo "$memory_usage > 0.9 " | bc) -eq 1 ]; then
    echo -e "\e[1;31mMemory:\e[0m \e[1;31m$memory_info\e[0m"
else
    echo -e "\e[1;36mMemory:\e[0m $memory_info"
fi

nc -z 1.1.1.1 53 > /null 2>&1 && echo -e "\e[1;32mInternet ON\e[0m" || echo "\e[1;31mDevice not connected to internet\e[0m"

