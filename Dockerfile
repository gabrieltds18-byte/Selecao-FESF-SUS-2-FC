# ============================================================
# Dockerfile — Backend (API FastAPI)
# Cria a imagem Docker para rodar a API Python
# ============================================================

# Usa a imagem oficial do Python 3.11 (versão slim = mais leve)
FROM python:3.11-slim

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Copia o arquivo de dependências primeiro
# (separado do código para aproveitar o cache do Docker)
COPY requirements.txt .

# Instala as dependências Python sem cache (economiza espaço)
RUN pip install --no-cache-dir -r requirements.txt

# Copia o código da API para dentro do container
COPY main.py .

# Expõe a porta 8000 para acesso externo
EXPOSE 8000

# Comando para iniciar o servidor quando o container subir
# --host 0.0.0.0 permite acesso de fora do container
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
