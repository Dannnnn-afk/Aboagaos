# Guía de Despliegue - Aboagaos

## Opciones de Despliegue

### Opción 1: Despliegue Local (Desarrollo)

Ya cubierto en [QUICKSTART.md](QUICKSTART.md)

---

### Opción 2: Despliegue en VPS (Virtual Private Server)

#### Requisitos
- Ubuntu 20.04+ o similar
- Node.js 14+
- MySQL 5.7+
- Nginx (recomendado)

#### Pasos

1. **Instalar dependencias del sistema**
```bash
# Actualizar sistema
sudo apt update && sudo apt upgrade -y

# Instalar Node.js
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs

# Instalar MySQL
sudo apt install -y mysql-server
sudo mysql_secure_installation

# Instalar Nginx
sudo apt install -y nginx

# Instalar PM2 (gestor de procesos)
sudo npm install -g pm2
```

2. **Configurar MySQL**
```bash
sudo mysql -u root -p

# Crear usuario y base de datos
CREATE DATABASE aboagaos_db;
CREATE USER 'aboagaos_user'@'localhost' IDENTIFIED BY 'password_seguro';
GRANT ALL PRIVILEGES ON aboagaos_db.* TO 'aboagaos_user'@'localhost';
FLUSH PRIVILEGES;
EXIT;

# Importar schema
mysql -u aboagaos_user -p aboagaos_db < backend/database.sql
```

3. **Clonar y configurar aplicación**
```bash
# Clonar repositorio
cd /var/www
sudo git clone https://github.com/Dannnnn-afk/Aboagaos.git
sudo chown -R $USER:$USER /var/www/Aboagaos
cd Aboagaos

# Instalar dependencias
npm run install-all

# Configurar backend
cd backend
cp .env.example .env
nano .env  # Editar con credenciales reales
```

Archivo `backend/.env` para producción:
```env
PORT=5000
DB_HOST=localhost
DB_USER=aboagaos_user
DB_PASSWORD=password_seguro
DB_NAME=aboagaos_db
NODE_ENV=production
```

4. **Construir frontend**
```bash
cd ../frontend
cp .env.example .env
nano .env  # Ajustar URL del API

# Build para producción
npm run build
```

Archivo `frontend/.env`:
```env
REACT_APP_API_URL=https://tu-dominio.com/api
```

5. **Configurar PM2 para backend**
```bash
cd ../backend
pm2 start server.js --name aboagaos-backend
pm2 save
pm2 startup
```

6. **Configurar Nginx**
```bash
sudo nano /etc/nginx/sites-available/aboagaos
```

Contenido:
```nginx
server {
    listen 80;
    server_name tu-dominio.com www.tu-dominio.com;

    # Frontend
    root /var/www/Aboagaos/frontend/build;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }

    # Backend API
    location /api {
        proxy_pass http://localhost:5000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```

```bash
# Habilitar sitio
sudo ln -s /etc/nginx/sites-available/aboagaos /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

7. **Configurar SSL con Let's Encrypt (Recomendado)**
```bash
sudo apt install -y certbot python3-certbot-nginx
sudo certbot --nginx -d tu-dominio.com -d www.tu-dominio.com
```

---

### Opción 3: Despliegue en la Nube

#### A. Backend en Heroku

1. **Preparar aplicación**
```bash
# Crear Procfile en backend/
echo "web: node server.js" > backend/Procfile
```

2. **Desplegar**
```bash
# Instalar Heroku CLI
# https://devcenter.heroku.com/articles/heroku-cli

cd backend
heroku login
heroku create aboagaos-api
heroku addons:create cleardb:ignite  # MySQL gratuito
heroku config:set NODE_ENV=production

# Configurar variables de entorno
heroku config:set DB_HOST=<cleardb-host>
heroku config:set DB_USER=<cleardb-user>
heroku config:set DB_PASSWORD=<cleardb-password>
heroku config:set DB_NAME=<cleardb-database>

git push heroku main
```

#### B. Frontend en Vercel/Netlify

**Vercel:**
```bash
cd frontend
npm install -g vercel
vercel login
vercel --prod
```

**Netlify:**
```bash
cd frontend
npm install -g netlify-cli
netlify login
netlify deploy --prod --dir=build
```

Configurar variable de entorno en Vercel/Netlify:
- `REACT_APP_API_URL=https://aboagaos-api.herokuapp.com/api`

---

### Opción 4: Despliegue con Docker

1. **Crear Dockerfile para Backend**

`backend/Dockerfile`:
```dockerfile
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm ci --only=production

COPY . .

EXPOSE 5000

CMD ["node", "server.js"]
```

2. **Crear Dockerfile para Frontend**

`frontend/Dockerfile`:
```dockerfile
FROM node:18-alpine as build

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
```

3. **Crear docker-compose.yml**

```yaml
version: '3.8'

services:
  mysql:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_DATABASE: aboagaos_db
      MYSQL_USER: aboagaos_user
      MYSQL_PASSWORD: password123
    volumes:
      - mysql_data:/var/lib/mysql
      - ./backend/database.sql:/docker-entrypoint-initdb.d/init.sql
    ports:
      - "3306:3306"

  backend:
    build: ./backend
    ports:
      - "5000:5000"
    environment:
      DB_HOST: mysql
      DB_USER: aboagaos_user
      DB_PASSWORD: password123
      DB_NAME: aboagaos_db
      PORT: 5000
    depends_on:
      - mysql

  frontend:
    build: ./frontend
    ports:
      - "80:80"
    depends_on:
      - backend

volumes:
  mysql_data:
```

4. **Ejecutar**
```bash
docker-compose up -d
```

---

## Checklist Post-Despliegue

- [ ] Base de datos accesible y poblada
- [ ] Backend responde en el endpoint correcto
- [ ] Frontend carga correctamente
- [ ] CORS configurado para el dominio de producción
- [ ] Variables de entorno configuradas
- [ ] SSL/HTTPS habilitado
- [ ] Backups de base de datos configurados
- [ ] Monitoreo configurado (opcional: New Relic, Datadog)
- [ ] Logs configurados (PM2 logs, aplicación logs)
- [ ] Dominio DNS configurado

## Mantenimiento

### Actualizar aplicación
```bash
cd /var/www/Aboagaos
git pull origin main
npm run install-all
cd frontend && npm run build
cd ../backend
pm2 restart aboagaos-backend
```

### Ver logs
```bash
pm2 logs aboagaos-backend
sudo tail -f /var/log/nginx/error.log
```

### Backup de base de datos
```bash
mysqldump -u aboagaos_user -p aboagaos_db > backup_$(date +%Y%m%d).sql
```

### Restaurar backup
```bash
mysql -u aboagaos_user -p aboagaos_db < backup_20240101.sql
```

## Solución de Problemas

### Backend no arranca
- Verificar logs: `pm2 logs aboagaos-backend`
- Verificar conexión MySQL: `mysql -u aboagaos_user -p aboagaos_db`
- Verificar puerto disponible: `netstat -tlnp | grep 5000`

### Frontend no carga
- Verificar Nginx: `sudo nginx -t`
- Ver logs: `sudo tail -f /var/log/nginx/error.log`
- Verificar build: `ls -la /var/www/Aboagaos/frontend/build`

### CORS errors
- Verificar que backend esté corriendo
- Confirmar URL del API en frontend/.env
- Revisar configuración CORS en backend/server.js

## Recursos Adicionales

- [PM2 Documentation](https://pm2.keymetrics.io/)
- [Nginx Documentation](https://nginx.org/en/docs/)
- [Let's Encrypt](https://letsencrypt.org/)
- [Docker Documentation](https://docs.docker.com/)
- [Heroku Dev Center](https://devcenter.heroku.com/)
