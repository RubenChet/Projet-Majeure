require('dotenv').config(); // Charge les variables d'environnement à partir du fichier .env
const express = require('express');
const connectToDatabase = require('./db');

const app = express();
const port = process.env.PORT || 3000;

connectToDatabase()
  .then(() => {
    console.log('Connexion à la base de données réussie');
  })
  .catch((error) => {
    console.error('Erreur lors de la connexion à la base de données', error);
  });

app.get('/', (req, res) => {
  res.send('Bienvenue sur le serveur');
});

app.listen(port, () => {
  console.log(`Le serveur est lancé sur le port ${port}`);
});
