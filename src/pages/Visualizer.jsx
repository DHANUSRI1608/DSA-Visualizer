import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import {
  Play,
  Zap,
  Grid,
  Box,
  Send,
  Link2,
  TreeDeciduous,
  Share2,
  ArrowLeft,
} from "lucide-react";

const Visualizer = () => {
  const navigate = useNavigate();
  const [hoveredCard, setHoveredCard] = useState(null);

  const dataStructures = [
    {
      id: "array",
      name: "Array",
      icon: <Grid size={24} />,
      color: "from-blue-500 to-cyan-500",
      description: "Visualize searching and sorting algorithms",
      difficulty: "Beginner",
    },
    {
      id: "stack",
      name: "Stack",
      icon: <Box size={24} />,
      color: "from-amber-500 to-orange-500",
      description: "Visualize LIFO operations like push and pop",
      difficulty: "Beginner",
    },
    {
      id: "queue",
      name: "Queue",
      icon: <Send size={24} />,
      color: "from-green-500 to-teal-500",
      description: "Visualize FIFO operations like enqueue and dequeue",
      difficulty: "Beginner",
    },
    {
      id: "linked-list",
      name: "Linked List",
      icon: <Link2 size={24} />,
      color: "from-purple-500 to-pink-500",
      description: "Visualize singly, doubly and circular linked lists",
      difficulty: "Intermediate",
    },
    {
      id: "tree",
      name: "Tree",
      icon: <TreeDeciduous size={24} />,
      color: "from-indigo-500 to-blue-500",
      description: "Visualize binary trees, BST, and traversal algorithms",
      difficulty: "Intermediate",
    },
    {
      id: "graph",
      name: "Graph",
      icon: <Share2 size={24} />,
      color: "from-red-500 to-pink-500",
      description: "Visualize graph algorithms like BFS, DFS, and Dijkstra",
      difficulty: "Advanced",
    },
  ];

  return (
    <div className="min-h-screen bg-gradient-to-br from-gray-900 via-gray-800 to-black text-white overflow-hidden">
      {/* Navbar */}
      <nav className="bg-gray-900/80 backdrop-blur-md shadow-lg flex items-center justify-between px-8 py-4 sticky top-0 z-40">
        <div className="flex items-center space-x-3">
          <button
            onClick={() => navigate("/")}
            className="p-2 hover:bg-gray-800 rounded-lg transition-colors duration-200 mr-2"
            title="Back to home"
          >
            <ArrowLeft size={20} className="text-indigo-400" />
          </button>
          <div className="w-10 h-10 rounded-lg bg-gradient-to-r from-indigo-600 to-purple-600 flex items-center justify-center shadow-md">
            <Zap size={20} className="text-white" />
          </div>
          <span className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-indigo-400 to-purple-400">
            DSA Visualizer
          </span>
        </div>
      </nav>

     {/* Header Section */}
<section className="max-w-6xl mx-auto px-6 pt-12 pb-8">
  <div className="text-center">
    <h1 className="text-4xl md:text-5xl font-extrabold leading-tight mb-3">
      <span className="bg-clip-text text-transparent bg-gradient-to-r from-indigo-400 to-pink-500">
        Data Structures
      </span>{" "}
      & Algorithms
    </h1>
    <p className="text-gray-400 text-lg max-w-2xl mx-auto">
      Learn and explore with interactive visualizations that bring core
      concepts to life.
    </p>
  </div>
</section>


      {/* Data Structures Grid */}
      <section className="max-w-7xl mx-auto px-6 pb-20">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {dataStructures.map((ds, index) => (
            <div
              key={ds.id}
              className={`group bg-gradient-to-br from-gray-800/60 to-gray-900/60 backdrop-blur-md rounded-2xl p-8 border border-gray-700 transition-all duration-300 hover:-translate-y-2 hover:shadow-2xl hover:shadow-indigo-500/20 ${
                hoveredCard === ds.id
                  ? "border-indigo-500 shadow-lg shadow-indigo-500/20"
                  : "hover:border-indigo-500"
              }`}
              onMouseEnter={() => setHoveredCard(ds.id)}
              onMouseLeave={() => setHoveredCard(null)}
              style={{ animationDelay: `${index * 0.1}s` }}
            >
              {/* Header */}
              <div className="flex items-center justify-between mb-6">
                <div
                  className={`bg-gradient-to-br ${ds.color} w-16 h-16 rounded-xl flex items-center justify-center text-white shadow-lg group-hover:scale-110 transition-transform duration-300`}
                >
                  {ds.icon}
                </div>
                <span
                  className={`text-xs font-medium px-3 py-1 rounded-full backdrop-blur-md ${
                    ds.difficulty === "Beginner"
                      ? "bg-green-500/20 text-green-400 border border-green-500/30"
                      : ds.difficulty === "Intermediate"
                      ? "bg-amber-500/20 text-amber-400 border border-amber-500/30"
                      : "bg-red-500/20 text-red-400 border border-red-500/30"
                  }`}
                >
                  {ds.difficulty}
                </span>
              </div>

              {/* Name */}
              <h3 className="text-2xl font-semibold mb-3 group-hover:text-indigo-400 transition-colors duration-200">
                {ds.name}
              </h3>

              {/* Description */}
              <p className="text-gray-400 mb-8 text-base leading-relaxed">{ds.description}</p>

              {/* Action buttons */}
              <div className="flex items-center justify-center mt-auto">
                <button
                  className="w-full bg-gradient-to-r from-indigo-600 to-purple-600 hover:from-indigo-700 hover:to-purple-700 px-6 py-3 rounded-lg shadow-md transition-all duration-300 hover:shadow-indigo-500/50 hover:scale-105 flex items-center justify-center font-semibold text-white text-base"
                  onClick={() => navigate(`/visualizer/${ds.id}`)}
                  aria-label={`Explore ${ds.name} visualizations`}
                >
                  <Play size={18} className="mr-2" />
                  Explore
                </button>
              </div>
            </div>
          ))}
        </div>
      </section>
    </div>
  );
};

export default Visualizer;
