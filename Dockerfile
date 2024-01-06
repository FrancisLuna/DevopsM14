# Utiliza la imagen oficial de Python 3.8 como punto de partida
FROM python:3.8

# Establece el directorio de trabajo en /
WORKDIR /

# Copia el archivo requirements.txt desde el directorio local al directorio de trabajo en la imagen Docker
COPY app/api/requirements.txt .

# Ejecuta el comando pip install dentro del contenedor para instalar las dependencias que se encuentran en requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Ejecuta un comando de Python para descargar datos adicionales necesarios
RUN python -c "import nltk; nltk.download('omw-1.4'); nltk.download('wordnet')"

# Copia todo el contenido del directorio local al directorio de trabajo en la imagen Docker. Esto incluirá tu aplicación Flask y cualquier otro archivo necesario para su ejecución.
COPY /app/api .

# Informa a Docker que el contenedor escuchará en el puerto 5000.
EXPOSE 5000

# Define el comando por defecto que se ejecutará cuando el contenedor se inicie
CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]
