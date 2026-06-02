import path from "node:path";

const isProduction = process.env.NODE_ENV === "production";

/** @type {import('next').NextConfig} */
const nextConfig = {
  allowedDevOrigins: ["127.0.0.1", "localhost"],
  images: {
    unoptimized: true
  },
  outputFileTracingRoot: path.resolve("./"),
  output: isProduction ? "export" : undefined,
  basePath: isProduction ? "/Ambiental" : "",
  trailingSlash: true
};

export default nextConfig;
