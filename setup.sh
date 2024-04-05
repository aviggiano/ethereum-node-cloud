set -eux

sudo apt-get update
sudo apt-get install -y ufw
sudo apt-get install -y net-tools
sudo ufw disable
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22/tcp # SSH access
sudo ufw allow 30303 # Geth P2P
sudo ufw allow 9000 # Lighthouse P2P
sudo ufw allow 80 # HTTP
sudo ufw allow 443 # HTTPS
sudo ufw enable

sudo ufw status verbose
sudo netstat -tlnp

yes | sudo add-apt-repository ppa:ethereum/ethereum
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y ethereum

sudo su <<EOF2
cat > /lib/systemd/system/geth.service << EOF
[Unit]

Description=Geth Full Node
After=network-online.target
Wants=network-online.target

[Service]

WorkingDirectory=/root
User=root
ExecStart=/usr/bin/geth --http --http.addr "0.0.0.0" --http.port "8545" --http.corsdomain "*" --http.api personal,eth,net,web3,debug,txpool,admin --authrpc.jwtsecret /tmp/jwtsecret --ws --ws.port 8546 --ws.api eth,net,web3,txpool,debug --ws.origins="*" --metrics --maxpeers 150 
Restart=always
RestartSec=5s

[Install]
WantedBy=multi-user.target
EOF
EOF2

sudo systemctl enable geth
sudo systemctl start geth

wget https://github.com/sigp/lighthouse/releases/download/v5.1.3/lighthouse-v5.1.3-x86_64-unknown-linux-gnu.tar.gz
tar zxvf lighthouse-v5.1.3-x86_64-unknown-linux-gnu.tar.gz
rm lighthouse-v5.1.3-x86_64-unknown-linux-gnu.tar.gz
sudo mv lighthouse /usr/local/bin/

sudo su <<EOF2
cat > /lib/systemd/system/lighthouse.service << EOF
[Unit]

Description=Lighthouse consensus client
After=network-online.target
Wants=network-online.target

[Service]

WorkingDirectory=/root
User=root
ExecStart=/usr/local/bin/lighthouse bn --network mainnet --execution-endpoint http://localhost:8551 --execution-jwt /tmp/jwtsecret --checkpoint-sync-url https://mainnet.checkpoint.sigp.io --disable-deposit-contract-sync
Restart=always
RestartSec=5s

[Install]
WantedBy=multi-user.target
EOF
EOF2

sudo systemctl enable lighthouse
sudo systemctl start lighthouse
