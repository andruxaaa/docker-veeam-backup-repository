# Usage
Prepare your NAS/Server: Install Docker, create a shared folder for the backups.

• Create a ssh key pair, e.g. `ssh-keygen -t rsa -C "your.email@example.com" -b 4096`
• Copy over the public key to your NAS/Server.
• Mount the public key to `/root/.ssh/authorized_keys` and a folder of your NAS to store your backups outside the container.
• Expose a port and map it to port 22.
• Veeam also needs some ports for the Agent to send data through (SSH is only used for running the commands), map a port range and define it in your Veeam
  backup infrastructure Linux server.  Protip: don't use too many ports (start with hundreds instead of thousands), or Docker will suffer.

```bash
docker run -d \
  -p 2222:22 \
  -p 2900-3000:2900-3000 \
  --name veeam \
  --restart always \
  -v $PWD/veeam.pub:/root/.ssh/authorized_keys \
  -v /mnt/vol/backups:/veeam \
kjake/veeam-backup-repository:latest
```

## Acknowledgments

- Thanks to [@t3easy](https://hub.docker.com/r/t3easy/veeam-backup-repository) for putting this together originally. 
