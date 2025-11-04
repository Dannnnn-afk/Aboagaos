# Arquitectura de la Aplicación Aboagaos

## Diagrama de Arquitectura

```
┌─────────────────────────────────────────────────────────┐
│                      NAVEGADOR                          │
│                   http://localhost:3000                 │
└────────────────────┬────────────────────────────────────┘
                     │
                     │  HTTP Requests
                     │  (Axios)
                     ▼
┌─────────────────────────────────────────────────────────┐
│                  FRONTEND (React)                       │
│  ┌───────────────────────────────────────────────────┐  │
│  │  Components:                                      │  │
│  │  - App.js (Main Container)                        │  │
│  │  - UserForm.js (Create/Edit Users)                │  │
│  │  - UserList.js (Display Users)                    │  │
│  └───────────────────────────────────────────────────┘  │
│  ┌───────────────────────────────────────────────────┐  │
│  │  Services:                                        │  │
│  │  - api.js (HTTP Client - Axios)                  │  │
│  └───────────────────────────────────────────────────┘  │
└────────────────────┬────────────────────────────────────┘
                     │
                     │  REST API Calls
                     │  GET, POST, PUT, DELETE
                     ▼
┌─────────────────────────────────────────────────────────┐
│              BACKEND (Node.js + Express)                │
│                   http://localhost:5000                 │
│  ┌───────────────────────────────────────────────────┐  │
│  │  Routes:                                          │  │
│  │  - /api/users (User Routes)                       │  │
│  └─────────────────┬─────────────────────────────────┘  │
│                    │                                     │
│  ┌─────────────────▼─────────────────────────────────┐  │
│  │  Controllers:                                     │  │
│  │  - userController.js (Business Logic)             │  │
│  └─────────────────┬─────────────────────────────────┘  │
│                    │                                     │
│  ┌─────────────────▼─────────────────────────────────┐  │
│  │  Models (Sequelize ORM):                          │  │
│  │  - User.js (User Model)                           │  │
│  └─────────────────┬─────────────────────────────────┘  │
│                    │                                     │
│  ┌─────────────────▼─────────────────────────────────┐  │
│  │  Config:                                          │  │
│  │  - database.js (DB Connection)                    │  │
│  └─────────────────┬─────────────────────────────────┘  │
└────────────────────┼─────────────────────────────────────┘
                     │
                     │  SQL Queries
                     │  (Sequelize ORM)
                     ▼
┌─────────────────────────────────────────────────────────┐
│                  DATABASE (MySQL)                       │
│  ┌───────────────────────────────────────────────────┐  │
│  │  Tables:                                          │  │
│  │  - users (id, name, email, age, timestamps)       │  │
│  └───────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
```

## Flujo de Datos

### 1. Crear Usuario (POST)
```
Usuario → UserForm → api.createUser() → POST /api/users
→ userController.createUser() → User.create()
→ MySQL INSERT → Respuesta JSON → Actualizar UI
```

### 2. Listar Usuarios (GET)
```
UserList → api.getUsers() → GET /api/users
→ userController.getAllUsers() → User.findAll()
→ MySQL SELECT → Respuesta JSON → Renderizar tabla
```

### 3. Actualizar Usuario (PUT)
```
Usuario → UserForm → api.updateUser(id) → PUT /api/users/:id
→ userController.updateUser() → User.findByPk() + save()
→ MySQL UPDATE → Respuesta JSON → Actualizar UI
```

### 4. Eliminar Usuario (DELETE)
```
Usuario → UserList → api.deleteUser(id) → DELETE /api/users/:id
→ userController.deleteUser() → User.destroy()
→ MySQL DELETE → Respuesta JSON → Actualizar UI
```

## Tecnologías por Capa

### Frontend
- **Framework:** React 18
- **HTTP Client:** Axios 1.13.2
- **Estilos:** CSS Inline (React Styles)
- **Build Tool:** Create React App (Webpack)

### Backend
- **Runtime:** Node.js
- **Framework:** Express 5.1.0
- **ORM:** Sequelize 6.37.7
- **Database Driver:** mysql2 3.15.3
- **Middleware:** CORS, dotenv

### Database
- **Sistema:** MySQL 5.7+
- **Codificación:** UTF-8
- **Motor:** InnoDB (por defecto)

## Patrones de Diseño Utilizados

### MVC (Model-View-Controller)
- **Model:** Sequelize models (User.js)
- **View:** React components (UserForm, UserList)
- **Controller:** Express controllers (userController.js)

### RESTful API
- Recursos identificados por URLs
- Verbos HTTP estándar (GET, POST, PUT, DELETE)
- Respuestas en formato JSON
- Status codes apropiados (200, 201, 404, 500)

### Separación de Responsabilidades
- **Routes:** Define endpoints y mapea a controllers
- **Controllers:** Lógica de negocio y coordinación
- **Models:** Definición de datos y relaciones
- **Services:** Comunicación HTTP (frontend)

## Variables de Entorno

### Backend (.env)
```
PORT=5000              # Puerto del servidor
DB_HOST=localhost      # Host de MySQL
DB_USER=root           # Usuario de MySQL
DB_PASSWORD=           # Contraseña de MySQL
DB_NAME=aboagaos_db    # Nombre de la base de datos
```

### Frontend (.env)
```
REACT_APP_API_URL=http://localhost:5000/api  # URL del backend
```

## Seguridad

✅ Variables de entorno para datos sensibles  
✅ CORS configurado correctamente  
✅ Validación de email en el modelo  
✅ Manejo de errores en todas las capas  
✅ Dependencias actualizadas (sin vulnerabilidades críticas)  
✅ CodeQL scan: Sin alertas de seguridad  

## Escalabilidad

### Mejoras Futuras Sugeridas
1. **Autenticación:** JWT o OAuth
2. **Paginación:** Limitar resultados en queries grandes
3. **Caché:** Redis para datos frecuentemente accedidos
4. **Rate Limiting:** Prevenir abuso de la API
5. **Logging:** Winston o Morgan para logs estructurados
6. **Testing:** Jest para unit tests, Cypress para E2E
7. **CI/CD:** GitHub Actions para deploy automático
8. **Containerización:** Docker para deployment consistente
