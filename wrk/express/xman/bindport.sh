sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080
# sudo iptables -t nat --line-numbers -n -L
# sudo iptables -t nat -D PREROUTING 2
