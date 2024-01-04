# docker-wireguard-tiny

Tested DSM version: 7.2.1-69057 Update 3

The following instructions provide a minimal Wireguard implementation for Synology NAS devices and only requires about 16MB of space.

These instructions assume that the NAS will be a "client" for an existing Wireguard "server".

_This has been forked from [irctrakz/docker-wireguard-tiny](https://github.com/irctrakz/docker-wireguard-tiny) and uses wireguard-go instead of Boringtun, which has better performance on Synology NAS devices with AMD Ryzen R1600 CPUs._

## Background

As of 1/3/2024, Synology's DSM software use an ancient Linux Kernel (version 4.4) which does not include support for Wireguard. Alternate solutions such as building Synology Package files (SPK) tend to require non-trivial dependencies for setup.

## Setup

1. Install Container Manager from the Synology Package Center
2. Copy the files in this repository to your NAS, e.g.: /volume1/docker/wireguard
3. Modify compose.yaml and wireguard.conf to match your configuration
   - [The Wireguard manual](https://git.zx2c4.com/wireguard-tools/about/src/man/wg.8) or [This Medium post](https://medium.com/@gstewart_47676/wireguard-made-ridiculously-easy-fa1ef176ce8e) provides additional details on how to set up wireguard.conf.
4. Open Container Manager, select Project, click Create
5. Provide a project name of your choice (e.g. "Wireguard")
6. Change the path to docker -> wireguard, select "use existing..."
7. Click Next and Start the container


# Performance Comparison

Tested using iperf3 with:
- Synology DS923+ with 10GbE module
- Intel i5-9600K PC with 10GbE network card

| Connection | Speed (Gbps) |
| --- | --- |
| Direct | 9.42 |
| Boringtun v0.6.0 | 1.51 |
| Wireguard-go (git 12269c2) | 2.92 |
