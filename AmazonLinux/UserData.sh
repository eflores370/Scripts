#!/bin/bash

sudo dnf update -y
sudo dnf install httpd mod_ssl -y
sudo systemctl start httpd
