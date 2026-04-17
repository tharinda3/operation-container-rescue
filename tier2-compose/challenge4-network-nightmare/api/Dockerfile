FROM python:3.11.6-slim-bookworm
WORKDIR /app
COPY requirements.txt .
RUN pip install --upgrade "pip>=25.3" "wheel>=0.46.2" && pip install -r requirements.txt
COPY app.py .
CMD ["python", "app.py"]
