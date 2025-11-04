# Guía de Inicio Rápido - Aboagaos

## Requisitos Previos
- Node.js v14+
- MySQL 5.7+
- npm

## Instalación Rápida

### 1. Clonar el repositorio
```bash
git clone https://github.com/Dannnnn-afk/Aboagaos.git
cd Aboagaos
```

### 2. Instalar dependencias
```bash
# Instalar todas las dependencias (backend y frontend)
npm run install-all
```

### 3. Configurar MySQL
```bash
# Iniciar sesión en MySQL
mysql -u root -p

# Ejecutar el script de base de datos
source backend/database.sql
# O importar manualmente:
mysql -u root -p < backend/database.sql
```

### 4. Configurar variables de entorno

**Backend** (`backend/.env`):
```env
PORT=5000
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=tu_password
DB_NAME=aboagaos_db
```

**Frontend** (`frontend/.env`):
```env
REACT_APP_API_URL=http://localhost:5000/api
```

### 5. Ejecutar la aplicación

**Terminal 1 - Backend:**
```bash
npm run dev-backend
```

**Terminal 2 - Frontend:**
```bash
npm run dev-frontend
```

### 6. Acceder a la aplicación
- **Frontend:** http://localhost:3000
- **Backend API:** http://localhost:5000
- **API Docs:** http://localhost:5000/api/users

## Solución de Problemas

### Error de conexión a la base de datos
- Verifica que MySQL esté corriendo
- Confirma las credenciales en `backend/.env`
- Asegúrate de que la base de datos `aboagaos_db` exista

### Puerto en uso
- Cambia el puerto en `backend/.env` (PORT=5001)
- O detén el proceso que está usando el puerto 5000

### Errores de CORS
- Verifica que el backend esté corriendo
- Confirma que `REACT_APP_API_URL` apunte al backend correcto

## Funcionalidades Disponibles

✅ **Crear usuarios** - Formulario con nombre, email y edad  
✅ **Listar usuarios** - Tabla con todos los usuarios  
✅ **Editar usuarios** - Actualizar información existente  
✅ **Eliminar usuarios** - Remover usuarios del sistema  

## Estructura de Datos

### Usuario
```json
{
  "id": 1,
  "name": "Juan Pérez",
  "email": "juan@example.com",
  "age": 30,
  "createdAt": "2024-01-01T00:00:00.000Z",
  "updatedAt": "2024-01-01T00:00:00.000Z"
}
```

## Comandos Útiles

```bash
# Instalar todas las dependencias
npm run install-all

# Iniciar backend en producción
npm run start-backend

# Iniciar backend en desarrollo
npm run dev-backend

# Iniciar frontend en desarrollo
npm run start-frontend

# Construir frontend para producción
npm run build-frontend
```

## Próximos Pasos

1. Personaliza los estilos según tu preferencia
2. Agrega autenticación de usuarios
3. Implementa más modelos (productos, pedidos, etc.)
4. Despliega en un servidor de producción
5. Configura HTTPS para conexiones seguras

## Soporte

Para más información, consulta el archivo [README.md](README.md)
