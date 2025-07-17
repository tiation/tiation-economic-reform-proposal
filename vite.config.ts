/**
 * Vite Configuration for The $19 Trillion Solution
 * Tiation & ChaseWhiteRabbit Initiative
 * 
 * Enterprise-grade build configuration with optimization,
 * security, and performance enhancements.
 */

import { defineConfig, loadEnv } from "vite";
import react from "@vitejs/plugin-react-swc";
import path from "path";
import type { UserConfig } from "vite";

// https://vitejs.dev/config/
export default defineConfig(({ command, mode }) => {
  // Load environment variables
  const env = loadEnv(mode, process.cwd(), "");
  
  const config: UserConfig = {
    base: "/tiation-economic-reform-proposal/",
    
    // Development server configuration
    server: {
      host: "::",
      port: 8080,
      strictPort: true,
      open: true,
      cors: true,
      headers: {
        "X-Frame-Options": "DENY",
        "X-Content-Type-Options": "nosniff",
        "Referrer-Policy": "strict-origin-when-cross-origin",
      },
    },
    
    // Preview server configuration
    preview: {
      port: 8080,
      strictPort: true,
      open: true,
      headers: {
        "X-Frame-Options": "DENY",
        "X-Content-Type-Options": "nosniff",
        "Referrer-Policy": "strict-origin-when-cross-origin",
      },
    },
    
    // Plugin configuration
    plugins: [
      react({
        // Enable React Fast Refresh
        fastRefresh: true,
        // Configure JSX runtime
        jsxRuntime: "automatic",
      }),
    ],
    
    // Module resolution
    resolve: {
      alias: {
        "@": path.resolve(__dirname, "./src"),
        "@/components": path.resolve(__dirname, "./src/components"),
        "@/hooks": path.resolve(__dirname, "./src/hooks"),
        "@/lib": path.resolve(__dirname, "./src/lib"),
        "@/pages": path.resolve(__dirname, "./src/pages"),
        "@/types": path.resolve(__dirname, "./src/types"),
        "@/utils": path.resolve(__dirname, "./src/utils"),
      },
    },
    
    // Build configuration
    build: {
      target: "es2020",
      outDir: "dist",
      assetsDir: "assets",
      sourcemap: mode === "development",
      minify: mode === "production" ? "terser" : false,
      
      // Rollup options
      rollupOptions: {
        output: {
          // Optimize chunk splitting
          manualChunks: {
            vendor: ["react", "react-dom"],
            ui: ["@radix-ui/react-accordion", "@radix-ui/react-dialog"],
            utils: ["clsx", "tailwind-merge", "class-variance-authority"],
          },
          // Asset naming
          assetFileNames: (assetInfo) => {
            const extType = assetInfo.name?.split(".").pop();
            if (/png|jpe?g|svg|gif|tiff|bmp|ico/i.test(extType ?? "")) {
              return `img/[name]-[hash][extname]`;
            }
            if (/css/i.test(extType ?? "")) {
              return `css/[name]-[hash][extname]`;
            }
            return `assets/[name]-[hash][extname]`;
          },
          chunkFileNames: "js/[name]-[hash].js",
          entryFileNames: "js/[name]-[hash].js",
        },
      },
      
      // Terser options for production
      terserOptions: {
        compress: {
          drop_console: mode === "production",
          drop_debugger: mode === "production",
        },
        format: {
          comments: false,
        },
      },
      
      // Chunk size warnings
      chunkSizeWarningLimit: 1000,
      
      // Assets inline threshold
      assetsInlineLimit: 4096,
    },
    
    // CSS configuration
    css: {
      modules: {
        scopeBehaviour: "local",
        generateScopedName: mode === "production" 
          ? "[hash:base64:8]" 
          : "[name]__[local]___[hash:base64:5]",
      },
      preprocessorOptions: {
        scss: {
          additionalData: `$injectedColor: orange;`,
        },
      },
    },
    
    // Environment variables
    define: {
      __APP_VERSION__: JSON.stringify(process.env.npm_package_version),
      __BUILD_DATE__: JSON.stringify(new Date().toISOString()),
    },
    
    // Optimization
    optimizeDeps: {
      include: [
        "react",
        "react-dom",
        "react-router-dom",
        "@tanstack/react-query",
      ],
      exclude: ["@vite/client", "@vite/env"],
    },
    
    // Error handling
    logLevel: "info",
    clearScreen: false,
  };
  
  return config;
});
