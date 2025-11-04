# Aboagaos
Abogaos Thelma

## Descripción
Aplicación web full-stack desarrollada con React (frontend), NodeJS/Express (backend) y MySQL (base de datos SQL). Sistema de gestión de usuarios con operaciones CRUD completas.

## Tecnologías Utilizadas

### Frontend
- React 18
- Axios para llamadas HTTP
- CSS inline para estilos

### Backend
- Node.js
- Express.js
- Sequelize ORM
- MySQL2
- CORS
- dotenv

### Base de Datos
- MySQL

## Estructura del Proyecto

```
Aboagaos/
├── frontend/          # Aplicación React
│   ├── src/
│   │   ├── components/
│   │   │   ├── UserForm.js
│   │   │   └── UserList.js
│   │   ├── services/
│   │   │   └── api.js
│   │   ├── App.js
│   │   └── index.js
│   └── package.json
│
├── backend/           # API NodeJS
│   ├── config/
│   │   └── database.js
│   ├── controllers/
│   │   └── userController.js
│   ├── models/
│   │   └── User.js
│   ├── routes/
│   │   └── users.js
│   ├── server.js
│   ├── database.sql
│   └── package.json
│
└── README.md
```

## Instalación y Configuración

### Requisitos Previos
- Node.js (v14 o superior)
- MySQL (v5.7 o superior)
- npm o yarn

### 1. Configurar la Base de Datos

Primero, crea la base de datos MySQL:

```bash
mysql -u root -p < backend/database.sql
```

O ejecuta manualmente en MySQL:
```sql
CREATE DATABASE IF NOT EXISTS aboagaos_db;
USE aboagaos_db;
```

### 2. Configurar el Backend

```bash
cd backend

# Instalar dependencias
npm install

# Crear archivo de configuración
cp .env.example .env

# Editar .env con tus credenciales de MySQL
# DB_HOST=localhost
# DB_USER=root
# DB_PASSWORD=tu_password
# DB_NAME=aboagaos_db
# PORT=5000
```

### 3. Configurar el Frontend

```bash
cd frontend

# Instalar dependencias
npm install

# Crear archivo de configuración
cp .env.example .env

# El archivo .env contendrá:
# REACT_APP_API_URL=http://localhost:5000/api
```

## Ejecución

### Iniciar el Backend

```bash
cd backend
npm start       # Producción
# o
npm run dev     # Desarrollo con nodemon
```

El servidor estará disponible en: `http://localhost:5000`

### Iniciar el Frontend

```bash
cd frontend
npm start
```

La aplicación estará disponible en: `http://localhost:3000`

## API Endpoints

### Usuarios

- `GET /api/users` - Obtener todos los usuarios
- `GET /api/users/:id` - Obtener un usuario por ID
- `POST /api/users` - Crear un nuevo usuario
- `PUT /api/users/:id` - Actualizar un usuario
- `DELETE /api/users/:id` - Eliminar un usuario

### Ejemplo de Petición POST

```json
{
  "name": "Juan Pérez",
  "email": "juan@example.com",
  "age": 30
}
```

## Características

- ✅ CRUD completo de usuarios
- ✅ Interfaz de usuario intuitiva
- ✅ Validación de formularios
- ✅ Manejo de errores
- ✅ Conexión a base de datos SQL
- ✅ API RESTful
- ✅ Arquitectura MVC
- ✅ ORM con Sequelize

## Desarrollo

### Scripts Disponibles

#### Backend
- `npm start` - Inicia el servidor
- `npm run dev` - Inicia el servidor en modo desarrollo con nodemon

#### Frontend
- `npm start` - Inicia la aplicación en modo desarrollo
- `npm run build` - Construye la aplicación para producción
- `npm test` - Ejecuta las pruebas

## Licencia

Este proyecto es de código abierto y está disponible bajo la Licencia ISC.
