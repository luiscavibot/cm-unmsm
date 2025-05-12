# ---------- build stage ----------
    FROM node:16 AS build

    # Paquetes que sí necesitas para compilar dependencias nativas
    RUN apt-get update && \
        apt-get install -y --no-install-recommends \
            build-essential \
            gcc \
            zlib1g-dev \
            libpng-dev \
            libvips-dev \
            git && \
        rm -rf /var/lib/apt/lists/*
    
    WORKDIR /opt/app
    
    # Copiamos solo los archivos de dependencias primero
    COPY package.json package-lock.json ./
    
    # Instala SÓLO prod deps, sin scripts opcionales y sin caché
    RUN npm ci --omit=dev --no-audit --prefer-offline
    
    # Copia el resto del código
    COPY . .
    
    RUN npm run build
    
    # ---------- runtime stage ----------
    FROM node:16
    
    RUN apt-get update && \
        apt-get install -y --no-install-recommends libvips-dev && \
        rm -rf /var/lib/apt/lists/*
    
    ENV NODE_ENV=production
    WORKDIR /opt/app
    
    # Copia los artefactos del build
    COPY --from=build /opt/app .
    
    # Ajusta permisos (opcional, si tu app los requiere)
    RUN chown -R node:node /opt/app
    USER node
    
    EXPOSE 1337
    CMD ["node", "dist/main.js"]
    