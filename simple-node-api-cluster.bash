#!/bin/bash

# Atualizar pacotes e instalar o Node.js
yum update -y
yum install -y curl
curl -fsSL https://rpm.nodesource.com/setup_18.x | bash -
yum install -y nodejs

# Criar diretórios para as APIs
mkdir -p /var/www/api-a
mkdir -p /var/www/api-b
mkdir -p /var/www/api-c

# Criar a API A
cat <<EOF > /var/www/api-a/server.js
const express = require('express');
const app = express();
const PORT = 3001;

app.get('/', (req, res) => {
    res.send('This is API A');
});

app.listen(PORT, () => {
    console.log(`API A is running on port ${PORT}`);
});
EOF

# Criar a API B
cat <<EOF > /var/www/api-b/server.js
const express = require('express');
const app = express();
const PORT = 3002;

app.get('/', (req, res) => {
    res.send('This is API B');
});

app.listen(PORT, () => {
    console.log(`API B is running on port ${PORT}`);
});
EOF

# Criar a API C
cat <<EOF > /var/www/api-c/server.js
const express = require('express');
const app = express();
const PORT = 3003;

app.get('/', (req, res) => {
    res.send('This is API C');
});

app.listen(PORT, () => {
    console.log(`API C is running on port ${PORT}`);
});
EOF

# Instalar o Express.js e iniciar as APIs
cd /var/www/api-a && npm init -y && npm install express && node server.js &
cd /var/www/api-b && npm init -y && npm install express && node server.js &
cd /var/www/api-c && npm init -y && npm install express && node server.js &

# Confirmar que as APIs estão em execução
echo "APIs configuradas e em execução:"
echo "API A: http://<seu-endereco>:3001"
echo "API B: http://<seu-endereco>:3002"
echo "API C: http://<seu-endereco>:3003"
