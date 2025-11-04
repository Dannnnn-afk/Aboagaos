import React, { useState, useEffect } from 'react';
import { createUser, updateUser } from '../services/api';

function UserForm({ userToEdit, onSuccess, onCancel }) {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    age: '',
  });
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    if (userToEdit) {
      setFormData({
        name: userToEdit.name || '',
        email: userToEdit.email || '',
        age: userToEdit.age || '',
      });
    }
  }, [userToEdit]);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prev) => ({
      ...prev,
      [name]: value,
    }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError(null);
    setLoading(true);

    try {
      if (userToEdit) {
        await updateUser(userToEdit.id, formData);
      } else {
        await createUser(formData);
      }
      setFormData({ name: '', email: '', age: '' });
      onSuccess();
    } catch (err) {
      setError('Error: ' + (err.response?.data?.message || err.message));
    } finally {
      setLoading(false);
    }
  };

  const handleCancel = () => {
    setFormData({ name: '', email: '', age: '' });
    setError(null);
    onCancel();
  };

  return (
    <div style={styles.container}>
      <h2 style={styles.title}>
        {userToEdit ? 'Editar Usuario' : 'Nuevo Usuario'}
      </h2>
      {error && <div style={styles.error}>{error}</div>}
      <form onSubmit={handleSubmit} style={styles.form}>
        <div style={styles.formGroup}>
          <label style={styles.label}>Nombre:</label>
          <input
            type="text"
            name="name"
            value={formData.name}
            onChange={handleChange}
            required
            style={styles.input}
            placeholder="Ingrese el nombre"
          />
        </div>
        <div style={styles.formGroup}>
          <label style={styles.label}>Email:</label>
          <input
            type="email"
            name="email"
            value={formData.email}
            onChange={handleChange}
            required
            style={styles.input}
            placeholder="ejemplo@email.com"
          />
        </div>
        <div style={styles.formGroup}>
          <label style={styles.label}>Edad:</label>
          <input
            type="number"
            name="age"
            value={formData.age}
            onChange={handleChange}
            style={styles.input}
            placeholder="Ingrese la edad (opcional)"
          />
        </div>
        <div style={styles.buttonGroup}>
          <button
            type="submit"
            disabled={loading}
            style={{...styles.button, ...styles.submitButton}}
          >
            {loading ? 'Guardando...' : userToEdit ? 'Actualizar' : 'Crear'}
          </button>
          {userToEdit && (
            <button
              type="button"
              onClick={handleCancel}
              style={{...styles.button, ...styles.cancelButton}}
            >
              Cancelar
            </button>
          )}
        </div>
      </form>
    </div>
  );
}

const styles = {
  container: {
    backgroundColor: 'white',
    padding: '20px',
    borderRadius: '8px',
    boxShadow: '0 2px 4px rgba(0,0,0,0.1)',
    marginBottom: '30px',
  },
  title: {
    color: '#333',
    marginBottom: '20px',
  },
  form: {
    display: 'flex',
    flexDirection: 'column',
  },
  formGroup: {
    marginBottom: '15px',
  },
  label: {
    display: 'block',
    marginBottom: '5px',
    color: '#555',
    fontWeight: 'bold',
  },
  input: {
    width: '100%',
    padding: '10px',
    border: '1px solid #ddd',
    borderRadius: '4px',
    fontSize: '14px',
    boxSizing: 'border-box',
  },
  buttonGroup: {
    display: 'flex',
    gap: '10px',
    marginTop: '10px',
  },
  button: {
    padding: '10px 20px',
    border: 'none',
    borderRadius: '4px',
    cursor: 'pointer',
    fontSize: '16px',
    fontWeight: 'bold',
  },
  submitButton: {
    backgroundColor: '#4CAF50',
    color: 'white',
  },
  cancelButton: {
    backgroundColor: '#9e9e9e',
    color: 'white',
  },
  error: {
    padding: '10px',
    marginBottom: '15px',
    color: '#f44336',
    backgroundColor: '#ffebee',
    borderRadius: '4px',
    fontSize: '14px',
  },
};

export default UserForm;
