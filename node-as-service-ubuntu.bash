### systemctl start api.service


[Unit]
Description=API # Descrição do serviço
After=network.target # Verifica se o serviço network iniciou para poder dá o start

[Service]
User=root
Type=simple

StandardOutput=append:/var/log/apis/api.log # Arquivo que irá receber a saída do comando ExecStart
StandardError=append:/var/log/apis/api.log # Arquivo que irá receber os erros do comando ExecStart

Environment="PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/usr/local/go/bin"
WorkingDirectory=/opt/apis/api-intergration/ # Diretório que esta os arquivos do API
ExecStart=/usr/bin/npm start # Comando usado para iniciar o API

[Install]
WantedBy=multi-user.target
