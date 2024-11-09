#!/bin/bash

rsync -avz /home/$(whoami)/Downloads/Sync/host/ osint@192.168.122.183:/home/osint/Sync/host/

rsync -avz osint@192.168.122.183:/home/osint/Sync/vm/ /home/$(whoami)/Downloads/Sync/vm/
