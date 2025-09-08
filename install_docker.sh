#!/bin/bash

# Скрипт установки Docker на Ubuntu
set -e  # Прерывать выполнение при любой ошибке

echo "=== Обновление списка пакетов ==="
sudo apt-get update

echo "=== Обновление установленных пакетов ==="
sudo apt-get upgrade -y

echo "=== Установка необходимых зависимостей ==="
sudo apt-get install -y ca-certificates curl

echo "=== Создание директории для ключей APT ==="
sudo install -m 0755 -d /etc/apt/keyrings

echo "=== Загрузка GPG-ключа Docker ==="
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo "=== Добавление репозитория Docker в sources.list ==="
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "=== Обновление списка пакетов с учетом нового репозитория ==="
sudo apt-get update

echo "=== Установка Docker и компонентов ==="
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "=== Проверка установки Docker ==="
sudo docker run --rm hello-world

echo "=== Установка Docker завершена успешно! ==="