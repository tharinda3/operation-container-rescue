FROM python:3.11-slim
WORKDIR /app
RUN pip install --upgrade "pip>=25.3" "wheel>=0.46.2" && pip install flask psycopg2-binary
COPY app.py .
CMD ["python", "app.py"]
