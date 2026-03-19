import path from "node:path";

/** @type {import('next').NextConfig} */
const nextConfig = {
  allowedDevOrigins: ["127.0.0.1", "localhost"],
  images: {
    unoptimized: true
  },
  outputFileTracingRoot: path.resolve("./")
};

export default nextConfig;
