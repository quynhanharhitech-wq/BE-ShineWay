@echo off
SET JAVA_VERSION=17
SET POSTGRES_VERSION=17
SET MAVEN_VERSION=3.8.4
SET CORE_SERVICE_PATH=..\core-service

:: Cập nhật hệ thống và cài đặt các gói yêu cầu
echo Cập nhật hệ thống...
powershell -Command "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser"

:: Cài đặt Java 17
echo Cài đặt Java 17...
if not exist "%ProgramFiles%\Java\jdk-%JAVA_VERSION%" (
    echo Tải và cài đặt Java 17...
    curl -L -o jdk-17.zip https://download.oracle.com/java/17/latest/jdk-17_windows-x64_bin.zip
    powershell -Command "Expand-Archive -Path jdk-17.zip -DestinationPath '%ProgramFiles%\Java'"
    del jdk-17.zip
) else (
    echo Java 17 đã được cài đặt.
)

:: Kiểm tra cài đặt Java
java -version

:: Cài đặt PostgreSQL 17
echo Cài đặt PostgreSQL 17...
powershell -Command "Invoke-WebRequest -Uri https://get.enterprisedb.com/postgresql/postgresql-%POSTGRES_VERSION%+-+windows-x64.exe -OutFile postgresql_installer.exe"
start /wait postgresql_installer.exe --mode unattended --superpassword "yourpassword" --datadir "C:\Program Files\PostgreSQL\%POSTGRES_VERSION%\data" --servicename "postgresql-%POSTGRES_VERSION%"
del postgresql_installer.exe

:: Kiểm tra PostgreSQL
echo Kiểm tra PostgreSQL...
psql --version
IF %ERRORLEVEL% NEQ 0 (
    echo PostgreSQL không cài đặt đúng cách. Vui lòng kiểm tra lại.
    exit /b 1
)

:: Cài đặt Maven
echo Cài đặt Maven...
powershell -Command "Invoke-WebRequest -Uri https://apache.claz.org/maven/maven-3/%MAVEN_VERSION%/binaries/apache-maven-%MAVEN_VERSION%-bin.zip -OutFile apache-maven.zip"
powershell -Command "Expand-Archive -Path apache-maven.zip -DestinationPath C:\Program Files"
del apache-maven.zip

:: Cài đặt PostgreSQL và chạy script SQL
echo Chạy script SQL để tạo cơ sở dữ liệu...
psql -U postgres -c "CREATE DATABASE shineway;"

:: Đảm bảo rằng script SQL nằm cùng thư mục với file .bat
set SQL_PATH=%~dp0shineway_db.sql

:: Chạy file SQL
psql -U postgres -d mydatabase -f "%SQL_PATH%"

:: Build core-service
echo Bắt đầu build core-service...
cd %CORE_SERVICE_PATH%
mvn clean install

echo Cài đặt hoàn tất!
pause
