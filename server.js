// app.js

// ----------------------------------------
// 1. Importar dependencias
// ----------------------------------------
const express = require('express');
const mysql   = require('mysql');

// ----------------------------------------
// 2. Leer la variable de entorno
// ----------------------------------------
const dbHost = process.env.DB_HOST;
if (!dbHost) {
  console.error('ERROR: La variable de entorno DB_HOST no está definida');
  process.exit(1);
}

// ----------------------------------------
// 3. Configurar la conexión a MySQL
// ----------------------------------------
const connection = mysql.createConnection({
  host     : dbHost,           // Ahora viene de process.env.DB_HOST
  port     : 3306,             // Puerto estándar MySQL
  user     : process.env.DB_USER     || 'usuario',   // opcionalmente también desde env
  password : process.env.DB_PASS     || 'usuario',   // opcionalmente también desde env
  database : process.env.DB_NAME     || 'movie_db'    // opcionalmente también desde env
});

connection.connect(err => {
  if (err) {
    console.error('Error al conectar a MySQL:', err);
    process.exit(1);
  }
  console.log(`✔ Conectado a MySQL en ${dbHost}:3306`);
});

// ----------------------------------------
// 3. Inicializar Express
// ----------------------------------------
const app = express();

// Endpoint de prueba
app.get('/', (req, res) => {
  res.json([{ response: 'hello' }, { code: '200' }]);
});

// ----------------------------------------
// 4. Endpoints que usan la base de datos
// ----------------------------------------

// 4.1 Obtener todas las películas
app.get('/movies', (req, res) => {
  const sql = `
    SELECT 
      m.title, 
      m.\`release\`, 
      m.score,
      r.name   AS reviewer, 
      p.name   AS publication
    FROM moviereview m
    JOIN reviewer r ON m.reviewer = r.name
    JOIN publication p ON r.publication = p.name;
  `;

  connection.query(sql, (err, results) => {
    if (err) {
      console.error('Error fetching movies:', err);
      return res.status(500).json({ error: 'Error interno al obtener películas' });
    }
    res.json(results);
  });
});

// 4.2 Obtener todos los revisores
app.get('/reviewers', (req, res) => {
  const sql = `SELECT name, avatar, publication FROM reviewer;`;

  connection.query(sql, (err, results) => {
    if (err) {
      console.error('Error fetching reviewers:', err);
      return res.status(500).json({ error: 'Error interno al obtener revisores' });
    }
    res.json(results);
  });
});

// 4.3 Obtener todas las publicaciones
app.get('/publications', (req, res) => {
  const sql = `SELECT name, avatar FROM publication;`;

  connection.query(sql, (err, results) => {
    if (err) {
      console.error('Error fetching publications:', err);
      return res.status(500).json({ error: 'Error interno al obtener publicaciones' });
    }
    res.json(results);
  });
});

// 4.4 Obtener reviews "pendientes" (ejemplo: score >=8 <10)
app.get('/pending', (req, res) => {
  const sql = `
    SELECT 
      m.title, 
      m.\`release\`, 
      m.score,
      r.name AS reviewer, 
      p.name AS publication
    FROM moviereview m
    JOIN reviewer r ON m.reviewer = r.name
    JOIN publication p ON r.publication = p.name
    WHERE m.score >= 8 AND m.score < 10;
  `;

  connection.query(sql, (err, results) => {
    if (err) {
      console.error('Error fetching pending reviews:', err);
      return res.status(500).json({ error: 'Error interno al obtener pendientes' });
    }
    res.json(results);
  });
});

// ----------------------------------------
// 5. Arrancar el servidor
// ----------------------------------------
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`🚀 Server listening on port ${PORT}`);
});

// ----------------------------------------
// 6. Cerrar conexión limpia al terminar
// ----------------------------------------
process.on('SIGINT', () => {
  connection.end(err => {
    if (err) console.error('Error al cerrar conexión MySQL:', err);
    else console.log('✔ Conexión MySQL cerrada');
    process.exit(0);
  });
});

module.exports = app;