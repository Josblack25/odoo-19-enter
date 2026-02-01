# Usamos una base de Python oficial
FROM python:3.11-slim-bookworm

# Instalamos dependencias del sistema necesarias para Odoo
RUN apt-get update && apt-get install -y \
    python3-dev \
    libxml2-dev \
    libxslt1-dev \
    libldap2-dev \
    libsasl2-dev \
    libtiff5-dev \
    libjpeg62-turbo-dev \
    zlib1g-dev \
    libfreetype6-dev \
    liblcms2-dev \
    libwebp-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libxcb1-dev \
    libpq-dev \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Crear directorio de trabajo
WORKDIR /opt/odoo

# Copiar el archivo de requerimientos de Odoo e instalar
COPY ./src/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar todo tu código de Odoo al contenedor
COPY . .

# Instalar Odoo como un paquete editable
RUN pip install -e .

# Exponer el puerto de Odoo
EXPOSE 8069

# Comando por defecto
ENTRYPOINT ["/opt/odoo/src/odoo-bin"]