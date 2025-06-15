# ─── Stage 1: Build Frontend ─────────────────────────────────────────
FROM node:18 AS frontend-build
WORKDIR /usr/src/app/frontend

# install deps, copy source, build + export static site
COPY frontend/package*.json ./
RUN npm ci
COPY frontend/ ./
# `next build` + `next export` → out/
RUN npm run build && npm run export


# ─── Stage 2: Install Backend & Embed Frontend ──────────────────────
FROM node:18 AS backend-build
WORKDIR /usr/src/app/backend

# install backend deps
COPY backend/package*.json ./
RUN npm ci

# copy backend source
COPY backend/ ./

# copy the static frontend into backend/public
COPY --from=frontend-build /usr/src/app/frontend/out ./public


# ─── Stage 3: Production Image ──────────────────────────────────────
FROM node:18-alpine AS production
WORKDIR /usr/src/app/backend

# copy everything from our backend-build
COPY --from=backend-build /usr/src/app/backend ./

# expose only the backend port
EXPOSE 5000

# run your Express server
CMD ["node", "server.js"]
