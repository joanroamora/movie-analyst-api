#!/bin/bash
sudo yum update -y
sudo yum install git -y
git clone https://github.com/joanroamora/movie-analyst-api.git
cd /home/ec2-user/movie-analyst-api
sudo yum install -y gcc-c++ make
curl -sL https://rpm.nodesource.com/setup_16.x | sudo -E bash
sudo yum install -y nodejs
npm install
sudo yum install mysql -y
sudo yum install telnet -y
#IMPORTANTE 

#mysql -h moviedb-rds.c5wjzkwslaaz.sa-east-1.rds.amazonaws.com -P 3306 -u admin -p
#CREATE DATABASE movie_db;
#USE movie_db;
#source /home/ec2-user/movie-analyst-api/data_model/table_creation_and_inserts.sql