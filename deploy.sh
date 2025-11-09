#!/bin/bash
# deploy.sh
# Build and push multi-architecture Docker image (Mac -> Linux server)
# with version tagging support

set -e  # Exit on any error

# --- Configuration ---
DOCKER_USER=${DOCKER_USER:-devdasz}     # ✅ Your Docker Hub username
APP_NAME=${APP_NAME:-node-hello}
APP_TAG=$(date +%Y%m%d%H%M)              # Timestamp tag, e.g., 202511091545
IMAGE_NAME="$DOCKER_USER/$APP_NAME:$APP_TAG"

# --- Ensure buildx is available ---
if ! docker buildx ls >/dev/null 2>&1; then
  echo "⚙️ Setting up Docker Buildx..."
  docker buildx create --use
fi

echo "🚀 Building and pushing Docker image for linux/amd64 + arm64..."
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t $IMAGE_NAME \
  -t $DOCKER_USER/$APP_NAME:latest \
  --push .

echo "✅ Build and push complete!"
echo "📦 Image available at:"
echo "   🔹 $IMAGE_NAME"
echo "   🔹 $DOCKER_USER/$APP_NAME:latest"
