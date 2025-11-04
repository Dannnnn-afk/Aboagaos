import React, { useState, useEffect } from 'react';
import { getUsers, deleteUser } from '../services/api';

function UserList({ onEdit, onRefresh }) {
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    fetchUsers();
  }, [onRefresh]);

  const fetchUsers = async () => {
    try {
      setLoading(true);
      const response = await getUsers();
      setUsers(response.data);
      setError(null);
    } catch (err) {
      setError('Error al cargar usuarios: ' + err.message);
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = async (id) => {
    if (window.confirm('¿Estás seguro de eliminar este usuario?')) {
      try {
        await deleteUser(id);
        fetchUsers();
      } catch (err) {
        alert('Error al eliminar usuario: ' + err.message);
      }
    }
  };

  if (loading) return <div style={styles.message}>Cargando...</div>;
  if (error) return <div style={styles.error}>{error}</div>;

  return (
    <div style={styles.container}>
      <h2 style={styles.title}>Lista de Usuarios</h2>
      {users.length === 0 ? (
        <p style={styles.message}>No hay usuarios registrados</p>
      ) : (
        <table style={styles.table}>
          <thead>
            <tr>
              <th style={styles.th}>ID</th>
              <th style={styles.th}>Nombre</th>
              <th style={styles.th}>Email</th>
              <th style={styles.th}>Edad</th>
              <th style={styles.th}>Acciones</th>
            </tr>
          </thead>
          <tbody>
            {users.map((user) => (
              <tr key={user.id} style={styles.tr}>
                <td style={styles.td}>{user.id}</td>
                <td style={styles.td}>{user.name}</td>
                <td style={styles.td}>{user.email}</td>
                <td style={styles.td}>{user.age || 'N/A'}</td>
                <td style={styles.td}>
                  <button
                    onClick={() => onEdit(user)}
                    style={{...styles.button, ...styles.editButton}}
                  >
                    Editar
                  </button>
                  <button
                    onClick={() => handleDelete(user.id)}
                    style={{...styles.button, ...styles.deleteButton}}
                  >
                    Eliminar
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  );
}

const styles = {
  container: {
    margin: '20px 0',
  },
  title: {
    color: '#333',
    marginBottom: '20px',
  },
  table: {
    width: '100%',
    borderCollapse: 'collapse',
    backgroundColor: 'white',
    boxShadow: '0 2px 4px rgba(0,0,0,0.1)',
  },
  th: {
    backgroundColor: '#4CAF50',
    color: 'white',
    padding: '12px',
    textAlign: 'left',
    fontWeight: 'bold',
  },
  tr: {
    borderBottom: '1px solid #ddd',
  },
  td: {
    padding: '12px',
  },
  button: {
    padding: '6px 12px',
    margin: '0 5px',
    border: 'none',
    borderRadius: '4px',
    cursor: 'pointer',
    fontSize: '14px',
  },
  editButton: {
    backgroundColor: '#2196F3',
    color: 'white',
  },
  deleteButton: {
    backgroundColor: '#f44336',
    color: 'white',
  },
  message: {
    padding: '20px',
    textAlign: 'center',
    color: '#666',
  },
  error: {
    padding: '20px',
    textAlign: 'center',
    color: '#f44336',
    backgroundColor: '#ffebee',
    borderRadius: '4px',
  },
};

export default UserList;
