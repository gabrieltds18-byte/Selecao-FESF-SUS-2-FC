# 🐳 Seleção FESF-SUS — 2 F.C

Containerização completa do sistema FESF-SUS utilizando **Docker** e **Docker Compose**, permitindo subir toda a aplicação (backend + frontend) com um único comando.

---

## 🚀 Tecnologias utilizadas

| Ferramenta | Função |
|-----------|--------|
| Docker | Containerização dos serviços |
| Docker Compose | Orquestração e comunicação entre containers |
| python:3.11-slim | Imagem base do backend |
| node:20-alpine | Imagem base do frontend (build multi-stage) |

---

## 📁 Estrutura do projeto

```
├── Dockerfile             # Container da API (Python/FastAPI)
├── Dockerfile.frontend    # Container do Frontend (Next.js)
├── docker-compose.yml     # Orquestração completa dos serviços
└── README.md
```

---

## ⚙️ Como executar

### Pré-requisito
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) instalado e rodando

### Subir toda a aplicação

```bash
docker-compose up --build
```

O Docker irá automaticamente:
1. Construir a imagem do **backend** (Python/FastAPI)
2. Construir a imagem do **frontend** (Next.js)
3. Criar uma rede interna entre os serviços
4. Iniciar os dois containers

### Acessar a aplicação

| Serviço | URL |
|---------|-----|
| Frontend | http://localhost:3000 |
| API | http://localhost:8000 |
| Documentação da API | http://localhost:8000/docs |

### Parar os containers

```bash
docker-compose down
```

---

## 🔧 Descrição dos serviços

### `backend`
- Imagem base: `python:3.11-slim`
- Porta exposta: `8000`
- Reinicia automaticamente em caso de falha
- Conectado à rede interna `fesf-network`

### `frontend`
- Imagem base: `node:20-alpine`
- Build em dois estágios (builder + runner) para imagem otimizada
- Porta exposta: `3000`
- Inicia somente após o backend estar disponível (`depends_on`)
- Conectado à rede interna `fesf-network`

---

## 🌐 Arquitetura

```
┌─────────────────────────────────────────┐
│           Docker Compose                │
│                                         │
│  ┌─────────────┐    ┌───────────────┐   │
│  │  frontend   │───▶│   backend     │   │
│  │  :3000      │    │   :8000       │   │
│  └─────────────┘    └───────────────┘   │
│         fesf-network (bridge)           │
└─────────────────────────────────────────┘
```

---

## 📝 Observações

- O `Dockerfile` utiliza a imagem `python:3.11-slim` para reduzir o tamanho final
- O `Dockerfile.frontend` usa build multi-stage para separar a etapa de compilação da execução, gerando uma imagem de produção mais leve
- O `docker-compose.yml` define uma rede bridge interna para os serviços se comunicarem pelo nome (`backend`, `frontend`) sem depender de IPs fixos
