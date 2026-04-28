# Docker Setup for DSA Visualizer

## Quick Start

### Development Mode (with hot reload)

```bash
docker-compose up dev
```

Access the app at: **http://localhost:5173**

### Production Mode

```bash
docker-compose up prod
```

Access the app at: **http://localhost:3000**

### Run Both Services

```bash
docker-compose up
```

---

## Commands Reference

### Build Images

```bash
# Build all services
docker-compose build

# Build specific service
docker-compose build dev    # For development
docker-compose build prod   # For production
```

### Start Services

```bash
# Start services in background
docker-compose up -d

# Start with logs displayed
docker-compose up

# Start specific service
docker-compose up dev
```

### Stop Services

```bash
# Stop all services
docker-compose down

# Stop without removing volumes
docker-compose stop

# Remove everything including volumes
docker-compose down -v
```

### View Logs

```bash
# View logs from all services
docker-compose logs -f

# View logs from specific service
docker-compose logs -f dev
docker-compose logs -f prod
```

### Access Container Shell

```bash
# Access development container shell
docker-compose exec dev sh

# Access production container shell
docker-compose exec prod sh
```

---

## Development Workflow

### With Docker (Recommended)

```bash
# Start dev container
docker-compose up dev

# Edit files locally - changes will hot-reload
# The container volume mounts your local code
```

### Build for Production

```bash
# Create production image
docker-compose build prod

# Run production container
docker-compose up prod
```

---

## Docker Images Explained

### Development Dockerfile (Dockerfile.dev)

- **Base Image**: `node:18-alpine`
- **Features**:
  - Installs all dependencies (including dev dependencies)
  - Runs `npm run dev` (Vite dev server on port 5173)
  - Hot-reload enabled with volume mounts
  - Health check included

### Production Dockerfile (Dockerfile)

- **Stage 1 - Builder**:
  - Uses `node:18-alpine` to build the app
  - Only installs production dependencies
  - Runs `npm run build` to create optimized dist folder

- **Stage 2 - Runtime**:
  - Uses `nginx:alpine` (lightweight web server)
  - Serves built files on port 80
  - Includes health checks
  - Optimized for production (multi-stage build reduces final image size)

---

## Docker Compose Services

### Service: `dev`

- **Dockerfile**: Dockerfile.dev
- **Port**: 5173 (Vite dev server)
- **Volumes**: Local code mounted for hot-reload
- **Environment**: NODE_ENV=development
- **Use Case**: Local development with live updates

### Service: `prod`

- **Dockerfile**: Dockerfile
- **Port**: 3000 (served by Nginx)
- **Environment**: NODE_ENV=production
- **Use Case**: Production deployment or testing

---

## Environment Variables

Create a `.env` file in the project root:

```env
# Development
NODE_ENV=development

# Production
NODE_ENV=production
```

---

## Networking

Both services connect via a custom bridge network `dsa-network`:

- Services can communicate with each other using service names
- Example: `http://dev:5173` from prod container

---

## Troubleshooting

### Port Already in Use

```bash
# Find process using port 5173
lsof -i :5173

# Find process using port 3000
lsof -i :3000

# Kill process (on Windows)
netstat -ano | findstr :5173
taskkill /PID <PID> /F
```

### Container Won't Start

```bash
# Check logs
docker-compose logs -f dev

# Rebuild image
docker-compose build --no-cache dev
```

### Hot-Reload Not Working

```bash
# Restart dev container
docker-compose restart dev

# Check volume mounts
docker inspect dsa-visualizer-dev | grep Mounts
```

### Clear Everything and Start Fresh

```bash
# Remove all containers, images, and volumes
docker-compose down -v

# Rebuild everything
docker-compose build

# Start fresh
docker-compose up dev
```

---

## Performance Tips

1. **Use .dockerignore** - Excludes unnecessary files from build context
2. **Multi-stage builds** - Production Dockerfile uses this for smaller images
3. **Alpine images** - Smaller base images (node:18-alpine, nginx:alpine)
4. **Production dependencies only** - Production build uses `npm ci --only=production`

---

## File Structure

```
DSA-Visualizer/
├── Dockerfile              # Production Dockerfile
├── Dockerfile.dev          # Development Dockerfile
├── docker-compose.yml      # Docker Compose configuration
├── .dockerignore           # Files to exclude from Docker build
├── nginx.conf              # Nginx configuration for production
├── package.json            # Node dependencies
├── vite.config.js          # Vite configuration
└── src/                    # Source code
```

---

## Next Steps

1. **Push to Docker Hub** (optional):

   ```bash
   docker tag dsa-visualizer-prod:latest yourusername/dsa-visualizer:latest
   docker push yourusername/dsa-visualizer:latest
   ```

2. **Deploy to Cloud** (AWS, GCP, Azure, etc.)

3. **Add CI/CD Pipeline** (GitHub Actions, GitLab CI, etc.)

---

## Additional Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Node.js in Docker Best Practices](https://nodejs.org/en/docs/guides/nodejs-docker-webapp/)
