#!/usr/bin/env bash

# Restarting Services if dead
systemctl is-active --quiet sonarr.service || systemctl restart sonarr.service