<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>

  <h1>🔮 DSA VISUALIZER</h1>
  <p><b>A POWERFUL DATA STRUCTURES & ALGORITHMS VISUALIZER</b> built with 
  <b>React (Vite)</b>, styled using <b>Tailwind CSS</b>, and fully containerized with 
  <b>Docker + Nginx</b>.  
  Learn, understand, and visualize popular algorithms like <b>Sorting, Searching, and Graph Traversal</b> in an interactive way.</p>

  <div class="section">
    <h2>✨ FEATURES</h2>
    <ul>
      <li> Step-by-step <b>visualization</b> of sorting algorithms</li>
      <li> <b>Graph & Tree traversal</b> animations</li>
      <li> Modern <b>UI powered by Tailwind CSS</b></li>
      <li> <b>Dockerized</b> → Run anywhere, <b>NO dependencies required</b></li>
      <li> <b>Super-fast development</b> with Vite</li>
    </ul>
  </div>

  <div class="section">
    <h2>🛠️ TECH STACK</h2>
    <ul>
      <li>⚛️ <b>Frontend:</b> React (Vite)</li>
      <li>🎨 <b>Styling:</b> Tailwind CSS</li>
      <li>🐳 <b>Containerization:</b> Docker, Docker Compose</li>
      <li>🌐 <b>Web Server (Production):</b> Nginx</li>
    </ul>
  </div>

  <div class="section">
    <h2>📂 PROJECT STRUCTURE</h2>
    <pre>
src/
 ┣ 📁 pages/           👉 Algorithm Pages
 ┣ 📄 App.jsx          👉 Root App Component
 ┣ 📄 main.jsx         👉 React Entry Point
 ┣ 🎨 index.css        👉 Global Styles
 ┣ 🌐 index.html       👉 Root HTML
 ┗ ...
📄 Dockerfile          👉 Production Build (React + Nginx)
📄 Dockerfile.dev      👉 Development Build (React + Vite)
📄 docker-compose.yml  👉 Compose Config
📄 nginx.conf          👉 Nginx Config for SPA Routing
    </pre>
  </div>

  <div class="section">
    🐳 RUNNING WITH DOCKER

    ✅ 1. PRODUCTION (Nginx Build)
 
docker build -t dsa-visualizer .
docker run -p 3000:80 dsa-visualizer
    </pre>
    <p>👉 Open in browser: <a href="http://localhost:3000" target="_blank">http://localhost:3000</a></p>

    ⚡ 2. DEVELOPMENT (Hot Reload with Vite)
   
docker compose -f docker-compose.yml up --build
    </pre>
    <p>👉 Open in browser: <a href="http://localhost:5173" target="_blank">http://localhost:5173</a></p>

   🌍 3. PULL DIRECTLY FROM DOCKER HUB
    <pre>
docker run -p 3000:80 dhanusri1608/dsa-visualizer:latest
    </pre>
  </div>

  <div class="section">
    👩‍💻 AUTHOR
    <p><b>Dhanusri R 🤍</b></p>
  </div>

  <div class="footer">
    © 2025 DSA Visualizer — Built with ❤️ using React, Tailwind, and Docker.
  </div>

</body>
</html>
