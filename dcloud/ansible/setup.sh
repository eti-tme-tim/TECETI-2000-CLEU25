#!/usr/bin/env bash

# Prep Python virtual environment
python3 -m venv .venv --prompt dcloud-ansible
source .venv/bin/activate

# Configure virtual environment
pip install --upgrade pip
pip install -r requirements.txt
