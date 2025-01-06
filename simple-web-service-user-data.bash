#!/bin/bash

# Atualizar pacotes e instalar o Apache
yum update -y
yum install -y httpd

# Habilitar o Apache para iniciar no boot
systemctl enable httpd

# Criar diretórios para as páginas
mkdir -p /var/www/html/a
mkdir -p /var/www/html/b
mkdir -p /var/www/html/c

# Criar as páginas HTML
cat <<EOF > /var/www/html/a/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Page A</title>
</head>
<body>
    <h1>This is Page A</h1>
</body>
</html>
EOF

cat <<EOF > /var/www/html/b/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Page B</title>
</head>
<body>
    <h1>This is Page B</h1>
</body>
</html>
EOF

cat <<EOF > /var/www/html/c/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Page C</title>
</head>
<body>
    <h1>This is Page C</h1>
</body>
</html>
EOF

# Configurar o Apache para servir as páginas
cat <<EOF > /etc/apache2/sites-available/pages.conf
<VirtualHost *:80>
    DocumentRoot /var/www/html

    Alias /a /var/www/html/a
    <Directory /var/www/html/a>
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
    </Directory>

    Alias /b /var/www/html/b
    <Directory /var/www/html/b>
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
    </Directory>

    Alias /c /var/www/html/c
    <Directory /var/www/html/c>
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
    </Directory>
</VirtualHost>
EOF

# Desabilitar a configuração padrão e habilitar a nova configuração
a2dissite 000-default.conf
a2ensite pages.conf

# Reiniciar o Apache para aplicar as mudanças
systemctl restart httpd
