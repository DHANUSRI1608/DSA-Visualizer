# Docker Setup Instructions for Windows

## Prerequisites

Make sure you have installed:

- **Docker Desktop** for Windows
- **Docker Compose** (included with Docker Desktop)

### Verify Installation

Open PowerShell and run:

```powershell
docker --version
docker-compose --version
```

You should see output like:

```
Docker version 28.3.3
Docker Compose version v2.39.2-desktop.1
```

---

## Step 1: Start Docker Desktop

1. Click the **Windows Start Menu**
2. Search for **"Docker Desktop"**
3. Click to open **Docker Desktop**
4. Wait for it to fully start (you'll see the Docker icon in the system tray)

### Check Docker Status

In PowerShell, run:

```powershell
docker ps
```

If you see a list of containers (even if empty), Docker is running! ✓

---

## Step 2: Build Docker Images

Navigate to the DSA Visualizer folder:

```powershell
cd C:\Users\usera\WEB_DEV\DSA-Visualizer
```

Build all images:

```powershell
docker-compose build
```

This will download base images and build your application containers.

---

## Step 3: Run the Application

### Option A: Development Mode (Recommended for Development)

```powershell
docker-compose up dev
```

Access at: **http://localhost:5173**

Features:

- Hot-reload enabled
- Live code changes reflected immediately
- Full dev tools available

### Option B: Production Mode

```powershell
docker-compose up prod
```

Access at: **http://localhost:3000**

Features:

- Optimized build
- Nginx server
- Production-ready

### Option C: Both Services

```powershell
docker-compose up
```

Runs both dev (5173) and prod (3000)

---

## Step 4: Useful Commands

### View Running Containers

```powershell
docker ps
```

### View Logs

```powershell
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f dev
```

### Access Container Shell

```powershell
docker-compose exec dev sh
```

### Stop Services

```powershell
# Stop but keep containers
docker-compose stop

# Stop and remove containers
docker-compose down
```

---

## Using Helper Scripts

### Windows Batch Script

Double-click `docker-helper.bat` or run in PowerShell:

```powershell
.\docker-helper.bat dev    # Start dev
.\docker-helper.bat prod   # Start prod
.\docker-helper.bat build  # Build images
.\docker-helper.bat help   # Show all commands
```

### Linux/Mac Bash Script

```bash
./docker-helper.sh dev    # Start dev
./docker-helper.sh prod   # Start prod
./docker-helper.sh build  # Build images
./docker-helper.sh help   # Show all commands
```

---

## Troubleshooting

### Docker Daemon Not Running

**Error**: `Error response from daemon`

**Solution**:

1. Open Docker Desktop from Start Menu
2. Wait for it to fully initialize
3. Check system tray for Docker icon (it will be running when you see it)

### Port Already in Use

**Error**: `Port 5173 is already allocated`

**Solution**:

```powershell
# Find what's using port 5173
netstat -ano | findstr :5173

# Kill the process (replace PID with actual number)
taskkill /PID <PID> /F

# Or use different port in docker-compose.yml
# Change "5173:5173" to "5174:5173"
```

### Out of Disk Space

**Error**: `no space left on device`

**Solution**:

```powershell
# Clean up Docker system
docker system prune -a

# Remove all containers, images, and volumes
docker-compose down -v
```

### Container Won't Start

```powershell
# Check logs
docker-compose logs dev

# Rebuild without cache
docker-compose build --no-cache dev
```

---

## Docker Architecture

```
┌─────────────────────────────────────────────────┐
│         Docker Compose (Orchestration)          │
├─────────────────────────────────────────────────┤
│                                                 │
│  ┌────────────────────┐  ┌─────────────────┐   │
│  │   Dev Container    │  │  Prod Container │   │
│  ├────────────────────┤  ├─────────────────┤   │
│  │ Node 18 Alpine     │  │ Nginx Alpine    │   │
│  │ Port: 5173         │  │ Port: 3000→80   │   │
│  │ Hot Reload: ✓      │  │ Optimized: ✓    │   │
│  │ Vite Dev Server    │  │ Nginx Server    │   │
│  └────────────────────┘  └─────────────────┘   │
│                                                 │
│  ┌─────────────────────────────────────────┐   │
│  │      Shared Network (dsa-network)       │   │
│  └─────────────────────────────────────────┘   │
│                                                 │
└─────────────────────────────────────────────────┘
```

---

## File Structure

```
DSA-Visualizer/
├── Dockerfile              # Multi-stage production build
├── Dockerfile.dev          # Development build
├── docker-compose.yml      # Compose configuration
├── .dockerignore           # Files to exclude from build
├── docker-helper.bat       # Windows helper script
├── docker-helper.sh        # Unix helper script
├── nginx.conf              # Nginx configuration
├── DOCKER.md               # Detailed Docker documentation
└── DOCKER-SETUP.md         # This file
```

---

## Next Steps

1. **Start Development**:

   ```powershell
   docker-compose up dev
   ```

2. **Edit Code** - Changes will hot-reload automatically

3. **Build for Production**:

   ```powershell
   docker-compose build prod
   ```

4. **Deploy** - Push images to Docker Hub or cloud services

---

## Additional Resources

- [Docker Desktop for Windows](https://docs.docker.com/desktop/install/windows-install/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Dockerfile Best Practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
- [Nginx Configuration](https://nginx.org/en/docs/)

---

## Quick Reference

| Command                  | Description                               |
| ------------------------ | ----------------------------------------- |
| `docker-compose up dev`  | Start dev server (http://localhost:5173)  |
| `docker-compose up prod` | Start prod server (http://localhost:3000) |
| `docker-compose build`   | Build all images                          |
| `docker-compose down`    | Stop all services                         |
| `docker-compose logs -f` | View all logs                             |
| `docker ps`              | List running containers                   |
| `docker system prune -a` | Clean up unused images/containers         |

---

## Support

If you encounter issues:

1. Check logs: `docker-compose logs -f`
2. Verify Docker is running
3. Restart Docker Desktop
4. Clear cache: `docker-compose down -v && docker-compose build --no-cache`
