#!/bin/bash

# Cập nhật các gói hiện có
echo "Cập nhật các gói hệ thống..."
sudo apt update -y
sudo apt upgrade -y

# Cài đặt Java 17
echo "Cài đặt Java 17..."
sudo apt install -y openjdk-17-jdk

# Kiểm tra cài đặt Java
java -version

# Cài đặt PostgreSQL 17
echo "Cài đặt PostgreSQL 17..."
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -c | awk "{print $2}")-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt update
sudo apt install -y postgresql-17 postgresql-client-17

# Khởi động dịch vụ PostgreSQL
sudo systemctl start postgresql
sudo systemctl enable postgresql

# Kiểm tra PostgreSQL
psql --version

# Cài đặt Maven
echo "Cài đặt Maven..."
sudo apt install -y maven

# Kiểm tra cài đặt Maven
mvn -v

# Cài đặt PostgreSQL và chạy script SQL
echo "Chạy script SQL để tạo cơ sở dữ liệu..."
# Tạo một cơ sở dữ liệu và chạy script.sql
sudo -u postgres psql -c "CREATE DATABASE mydatabase;"
psql -U postgres -d mydatabase -f /shineway_db.sql

# Build core-service
echo "Bắt đầu build core-service..."
cd ../core-service || { echo "Không thể tìm thấy thư mục core-service"; exit 1; }
mvn clean install


echo "Cài đặt hoàn tất!"
