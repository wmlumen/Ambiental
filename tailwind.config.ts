import type { Config } from "tailwindcss";

const config: Config = {
  content: [
    "./app/**/*.{ts,tsx}",
    "./components/**/*.{ts,tsx}",
    "./content/**/*.{md,mdx}",
    "./lib/**/*.{ts,tsx}"
  ],
  theme: {
    extend: {
      colors: {
        moss: {
          50: "#f3f8f2",
          100: "#e1eedf",
          200: "#c3dcc0",
          300: "#9cc29a",
          400: "#74a173",
          500: "#568458",
          600: "#426946",
          700: "#33513a",
          800: "#293f2f",
          900: "#1f3025",
          950: "#102018"
        },
        clay: {
          50: "#fcf6ef",
          100: "#f7e7d7",
          200: "#eed0af",
          300: "#e1b27d",
          400: "#cf8d4f",
          500: "#b86d33",
          600: "#985729",
          700: "#794522",
          800: "#633a21",
          900: "#52311f",
          950: "#2e190d"
        },
        lagoon: {
          50: "#edf8f8",
          100: "#d3eff0",
          200: "#abdfe3",
          300: "#79c7cf",
          400: "#45a8b5",
          500: "#2f8897",
          600: "#276e7e",
          700: "#215867",
          800: "#1d4856",
          900: "#193b47",
          950: "#0d232b"
        }
      },
      boxShadow: {
        soft: "0 24px 60px rgba(16, 32, 24, 0.12), 0 8px 24px rgba(20, 56, 66, 0.08)"
      },
      fontFamily: {
        display: ["Georgia", "Times New Roman", "serif"],
        body: ["Segoe UI Variable", "Trebuchet MS", "sans-serif"]
      }
    }
  },
  plugins: [require("@tailwindcss/typography")]
};

export default config;
