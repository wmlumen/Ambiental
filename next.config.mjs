import path from "node:path";

const isGitHubPages = process.env.GITHUB_PAGES === "true";
const isVercel = process.env.VERCEL === "1";

/** @type {import('next').NextConfig} */
const nextConfig = {
  allowedDevOrigins: ["127.0.0.1", "localhost"],
  images: {
    unoptimized: true
  },
  outputFileTracingRoot: path.resolve("./"),
  output: isGitHubPages ? "export" : undefined,
  basePath: isGitHubPages ? "/Ambiental" : "",
  trailingSlash: true
};

export default nextConfig;
