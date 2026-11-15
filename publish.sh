#!/bin/bash
set -e

# Переходим в директорию quartz
cd "$(dirname "$0")"

# Если вы используете связку с Obsidian, укажите путь к вашему хранилищу здесь:
# Например: SRC="/home/misha/Documents/Vault"
# Если редактируете файлы прямо в quartz/content, оставьте пустым: SRC=""
SRC="/home/misha/trubmd"

if [ -n "$SRC" ] && [ -d "$SRC" ]; then
    echo "==> Синхронизация контента из Obsidian..."
    rm -rf content
    mkdir -p content
    cp -a "$SRC"/. content/
    rm -rf content/.obsidian content/private content/.trash
fi

echo "==> Индексация изменений в git..."
git add -A

# Проверяем, есть ли реальные изменения для коммита
if git diff-index --quiet HEAD --; then
    echo "==> Нет новых изменений для публикации. Всё актуально!"
    exit 0
fi

echo "==> Создание коммита..."
git commit -m "Обновление сайта: $(date '+%Y-%m-%d %H:%M')"

echo "==> Публикация на GitHub..."
git push pages site:main

echo "==> Готово! Изменения отправлены."
