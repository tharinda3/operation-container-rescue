FROM python:3.11.6-slim-bookworm

WORKDIR /app

COPY app.py .

RUN pip install --upgrade "pip>=25.3" "wheel>=0.46.2" && pip install flask

CMD ["python", "app.py"]
