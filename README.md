# Minecraft server management

This is mostly a brain dump for the next time I need to configure a Minecraft server.

## Requirements

- Install via aptitude `openjdk-8-jre-headless`
- Install mcrcon: https://github.com/Tiiffi/mcrcon

## Installation

- Create a directory in `/srv/minecraft`
- Download Minecraft server using `wget` using the link from https://www.minecraft.net/en-us/download/server
- Copy `minecraft.service` to `/etc/systemd/system/`
- Run `echo "eula=true" > eula.txt`
