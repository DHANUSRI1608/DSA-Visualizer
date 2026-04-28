#!/bin/bash
# Docker Helper Script for DSA Visualizer

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print colored output
print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# Function to show help
show_help() {
    echo -e "${BLUE}DSA Visualizer - Docker Helper${NC}"
    echo ""
    echo "Usage: ./docker-helper.sh [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  dev             Start development server (http://localhost:5173)"
    echo "  prod            Start production server (http://localhost:3000)"
    echo "  build           Build all Docker images"
    echo "  up              Start all services"
    echo "  down            Stop all services"
    echo "  logs            View logs from all services"
    echo "  logs-dev        View logs from dev service"
    echo "  logs-prod       View logs from prod service"
    echo "  shell-dev       Access dev container shell"
    echo "  shell-prod      Access prod container shell"
    echo "  clean           Remove all containers and volumes"
    echo "  restart         Restart all services"
    echo "  status          Show status of all services"
    echo "  help            Show this help message"
    echo ""
}

# Parse command
case "${1:-help}" in
    dev)
        print_info "Starting development server..."
        docker-compose up dev
        ;;
    prod)
        print_info "Starting production server..."
        docker-compose up prod
        ;;
    build)
        print_info "Building Docker images..."
        docker-compose build
        print_success "Build complete"
        ;;
    up)
        print_info "Starting all services..."
        docker-compose up -d
        print_success "Services started"
        print_info "Dev: http://localhost:5173"
        print_info "Prod: http://localhost:3000"
        ;;
    down)
        print_info "Stopping all services..."
        docker-compose down
        print_success "Services stopped"
        ;;
    logs)
        print_info "Viewing logs..."
        docker-compose logs -f
        ;;
    logs-dev)
        print_info "Viewing dev logs..."
        docker-compose logs -f dev
        ;;
    logs-prod)
        print_info "Viewing prod logs..."
        docker-compose logs -f prod
        ;;
    shell-dev)
        print_info "Accessing dev container shell..."
        docker-compose exec dev sh
        ;;
    shell-prod)
        print_info "Accessing prod container shell..."
        docker-compose exec prod sh
        ;;
    clean)
        print_warning "This will remove all containers and volumes"
        read -p "Continue? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            print_info "Cleaning up..."
            docker-compose down -v
            print_success "Cleanup complete"
        else
            print_info "Cleanup cancelled"
        fi
        ;;
    restart)
        print_info "Restarting all services..."
        docker-compose restart
        print_success "Services restarted"
        ;;
    status)
        print_info "Container status:"
        docker-compose ps
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        print_error "Unknown command: $1"
        show_help
        exit 1
        ;;
esac
