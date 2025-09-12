# --- Builder Stage ---
FROM node:18-alpine AS builder

WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy the rest of the application
COPY . .

# Set build argument and write to .env.local for Next.js
ARG NEXT_PUBLIC_API_URL
RUN echo "NEXT_PUBLIC_API_URL=$NEXT_PUBLIC_API_URL" > .env.local

# Build the application
RUN npm run build

# --- Production Stage ---

# --- Production Stage ---
FROM gcr.io/distroless/nodejs18-debian11 AS runner


WORKDIR /app

# Copy only necessary files from builder
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/package.json ./
COPY --from=builder /app/package-lock.json ./
COPY --from=builder /app/.env.local ./.env.local

# Install only production dependencies using a temporary Node image
FROM node:18-alpine AS prod-deps
WORKDIR /app
COPY --from=builder /app/package.json ./
COPY --from=builder /app/package-lock.json ./
RUN npm ci --omit=dev

# Copy node_modules from prod-deps to runner
COPY --from=prod-deps /app/node_modules ./node_modules

# Expose the port the app runs on
EXPOSE 3000

# Start the Next.js server using distroless
CMD [".nodejs/bin/node", "node_modules/next/dist/bin/next", "start"]