#!/bin/bash
set -e
read -p "Do you want to build HDFS source code? (y/n) " yn

case $yn in y )
  # Build HDFS
  docker exec hadoop-repro bash -c "cd hadoop-common-project && mvn -nsu clean package install -Pdist -DskipTests -Dtar -Dmaven.javadoc.skip=true"
  docker exec hadoop-repro bash -c "cd hadoop-hdfs-project && mvn -nsu clean package install -Pdist -DskipTests -Dtar -Dmaven.javadoc.skip=true"
  docker exec hadoop-repro bash -c "cd hadoop-yarn-project && mvn -nsu clean package install -Pdist -DskipTests -Dtar -Dmaven.javadoc.skip=true"
  docker exec hadoop-repro bash -c "cd hadoop-dist && mvn -nsu clean package -Pdist -DskipTests -Dtar -Dmaven.javadoc.skip=true"
esac

# Build docker
docker build --no-cache -t hdfs-repro:latest -f Dockerfile ..

# Restart docker-compose
docker compose stop && docker-compose rm -f

# Start the docker-compose
docker compose up -d