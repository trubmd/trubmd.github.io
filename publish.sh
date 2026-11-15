#!/bin/bash
cd ~/quartz
rm -rf content && mkdir content && cp -a /home/misha/trubmd/. content/ && rm -rf content/.obsidian content/private content/.trash
git add -A
git commit -m "Обновление $(date +%F)" || true
git push pages site:main
