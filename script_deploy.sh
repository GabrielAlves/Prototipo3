#!/bin/bash

set -e

docker compose up -d --build

echo "Aguardando aplicação ficar disponível..."

# checa se o frontend está disponível. O frontend depende do back e do bd no docker-compose
until curl -sf http://localhost:5003/ > /dev/null
do
    sleep 1
done

echo "executando testes"

docker compose exec -T backend python -m pytest --disable-warnings

echo "Tela da aplicação: http://127.0.0.1:5003"
echo "Status do backend: http://127.0.0.1:8002/health"