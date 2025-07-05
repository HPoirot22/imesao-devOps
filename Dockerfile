FROM python:3.13.4-alpine3.22
# Use uma imagem base do Python estável e oficial.
# Imagens Alpine são menores, o que é ótimo para produção.


# Define o diretório de trabalho dentro do contêiner.
WORKDIR /app

# Copia o arquivo de dependências primeiro para aproveitar o cache do Docker.
# O passo de instalação só será executado novamente se o requirements.txt mudar.
COPY requirements.txt .

# Instala as dependências listadas no requirements.txt.
# A flag --no-cache-dir ajuda a manter o tamanho da imagem menor.
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho.
COPY . .

# Expõe a porta 8000 para que o mundo exterior possa se conectar ao contêiner.
EXPOSE 8000

# Define o comando para executar a aplicação quando o contêiner iniciar.
# Usamos 0.0.0.0 para que a aplicação seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
