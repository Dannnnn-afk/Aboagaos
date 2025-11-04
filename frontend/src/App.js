import React, { useState } from 'react';
import UserForm from './components/UserForm';
import UserList from './components/UserList';

function App() {
  const [userToEdit, setUserToEdit] = useState(null);
  const [refreshKey, setRefreshKey] = useState(0);

  const handleSuccess = () => {
    setUserToEdit(null);
    setRefreshKey((prev) => prev + 1);
  };

  const handleEdit = (user) => {
    setUserToEdit(user);
  };

  const handleCancel = () => {
    setUserToEdit(null);
  };

  return (
    <div style={styles.container}>
      <header style={styles.header}>
        <h1 style={styles.mainTitle}>Aboagaos - Sistema de Gestión</h1>
        <p style={styles.subtitle}>Aplicación web con React, NodeJS y SQL</p>
      </header>
      <main style={styles.main}>
        <UserForm
          userToEdit={userToEdit}
          onSuccess={handleSuccess}
          onCancel={handleCancel}
        />
        <UserList
          onEdit={handleEdit}
          onRefresh={refreshKey}
        />
      </main>
      <footer style={styles.footer}>
        <p>© 2024 Aboagaos - Thelma</p>
      </footer>
    </div>
  );
}

const styles = {
  container: {
    minHeight: '100vh',
    backgroundColor: '#f5f5f5',
    display: 'flex',
    flexDirection: 'column',
  },
  header: {
    backgroundColor: '#4CAF50',
    color: 'white',
    padding: '30px 20px',
    textAlign: 'center',
    boxShadow: '0 2px 4px rgba(0,0,0,0.1)',
  },
  mainTitle: {
    margin: '0 0 10px 0',
    fontSize: '32px',
  },
  subtitle: {
    margin: '0',
    fontSize: '16px',
    opacity: '0.9',
  },
  main: {
    flex: '1',
    maxWidth: '1200px',
    width: '100%',
    margin: '0 auto',
    padding: '30px 20px',
  },
  footer: {
    backgroundColor: '#333',
    color: 'white',
    textAlign: 'center',
    padding: '20px',
    marginTop: 'auto',
  },
};

export default App;
