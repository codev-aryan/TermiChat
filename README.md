# TermiChat

A lightweight, terminal-based chat application built with Bash that enables real-time communication between multiple users over a local network.

## Features

- **Server/Client Architecture**: Host or join chat rooms with ease
- **Multi-User Support**: Multiple clients can connect to a single server simultaneously
- **Timestamped Messages**: Each message includes a timestamp for better context
- **Color-Coded Interface**: Clean, readable UI with color-coded elements
- **Zero External Dependencies**: Uses only `ncat` (part of the nmap package)
- **Cross-Platform**: Works on any Linux distribution with Bash

## Prerequisites

- Linux-based operating system (tested on Garuda Linux / Arch Linux)
- Bash shell
- `ncat` utility (from the nmap package)

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/codev-aryan/termichat.git
cd termichat
```

### 2. Install Dependencies

#### On Arch Linux / Garuda Linux:
```bash
sudo pacman -S nmap
```

#### On Debian / Ubuntu:
```bash
sudo apt install ncat
```

#### On Fedora / RHEL:
```bash
sudo dnf install nmap-ncat
```

### 3. Make the Script Executable

```bash
chmod +x termichat.sh
```

## Usage

### Starting a Chat Server

1. Run the script:
   ```bash
   ./termichat.sh
   ```

2. Select option `1` (Server)

3. Enter a port number (default: 12345)

4. The server will display your local IP address and start listening for connections

5. Share your IP address and port with clients who want to join

### Joining a Chat Room

1. Run the script:
   ```bash
   ./termichat.sh
   ```

2. Select option `2` (Client)

3. Enter the server IP address

4. Enter the server port (default: 12345)

5. Enter your username

6. Start chatting!

## Example Session

**Server:**
```
$ ./termichat.sh
Select Mode:
1) Server (Host the Chat Room)
2) Client (Join a Chat Room)

Enter choice [1 or 2]: 1
Enter Port to listen on (default 12345): 12345

Server listening on IP: 192.168.1.100
Server listening on Port: 12345
Waiting for clients to connect...
```

**Client:**
```
$ ./termichat.sh
Select Mode:
1) Server (Host the Chat Room)
2) Client (Join a Chat Room)

Enter choice [1 or 2]: 2
Enter Server IP: 192.168.1.100
Enter Server Port (default 12345): 12345
Enter your Username: Alice

Connected to chat as [Alice]
Type a message and press Enter to send.
------------------------------------------------
[14:32] [Alice]: Hello everyone!
```

## How It Works

TermiChat uses `ncat` in broker mode to create a multi-user chat hub:

- **Server Mode**: Runs `ncat` with the `--broker` flag, which acts as a message relay between all connected clients
- **Client Mode**: Connects to the server and formats outgoing messages with timestamps and usernames
- **Message Format**: `[HH:MM] [Username]: Message`

## Network Configuration

- **Local Network**: Works out of the box on the same LAN
- **External Access**: To allow connections from outside your network, configure port forwarding on your router
- **Firewall**: Ensure the chosen port is open in your firewall:
  ```bash
  sudo ufw allow 12345/tcp  # For UFW users
  ```

## Limitations

- No message encryption (plaintext over network)
- No message history or logging
- No authentication system
- Limited to IPv4 addresses
- Requires manual IP address sharing

## Troubleshooting

### "ncat: command not found"
Install the nmap package using your distribution's package manager.

### "Connection refused"
- Verify the server is running
- Check that the IP address and port are correct
- Ensure no firewall is blocking the connection
- Confirm both devices are on the same network

### Messages not appearing
- Check network connectivity between server and client
- Verify the correct port is being used
- Try restarting both server and client

## Contributing

Contributions are welcome! Feel free to:

- Report bugs
- Suggest new features
- Submit pull requests

## License

This project is open source and available under the MIT License.

## Author

Created by [codev-aryan](https://github.com/codev-aryan)

## Acknowledgments

- Built with `ncat` from the Nmap Project
- Inspired by classic IRC chat systems

---
