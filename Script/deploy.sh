#!/bin/bash

# Variables
IMAGE_NAME="nodeapp"
CONTAINER_NAME="nodeapp_container"
PORT=3000

echo "🔨 Building Docker image..."
docker build -t $IMAGE_NAME .

if [ $? -ne 0 ]; then
  echo "❌ Image build failed"
  exit 1
fi

echo "🚀 Running container..."
docker run -d --name $CONTAINER_NAME -p $PORT:$PORT $IMAGE_NAME

if [ $? -ne 0 ]; then
  echo "❌ Container failed to start"
  exit 1
fi

echo "⏳ Waiting for app to start..."
sleep 5

echo "🔎 Checking application health..."

STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:$PORT/health)

if [ "$STATUS" -eq 200 ]; then
  echo "✅ Application is healthy (HTTP $STATUS)"
else
  echo "❌ Application is not healthy (HTTP $STATUS)"
  docker logs $CONTAINER_NAME
  exit 1
fi

echo "🎉 Deployment Successful!"
