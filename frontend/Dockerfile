# --- Builder Stage ---
FROM node:18-alpine AS builder
WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
ARG NEXT_PUBLIC_API_URL
RUN echo "NEXT_PUBLIC_API_URL=$NEXT_PUBLIC_API_URL" > .env.local
RUN npm run build

# --- Production Dependencies Stage ---
FROM node:18-alpine AS prod-deps
WORKDIR /app
COPY --from=builder /app/package.json ./ 
COPY --from=builder /app/package-lock.json ./
RUN npm ci --omit=dev

# --- Production Stage ---
FROM gcr.io/distroless/nodejs18-debian11 AS runner
WORKDIR /app

# Copy app from builder
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/package.json ./ 
COPY --from=builder /app/package-lock.json ./
COPY --from=builder /app/.env.local ./.env.local

# Copy node_modules from prod-deps
COPY --from=prod-deps /app/node_modules ./node_modules

EXPOSE 3000
CMD [".nodejs/bin/node", "node_modules/next/dist/bin/next", "start"]
