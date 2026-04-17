FROM <INTERNAL_REGISTRY>/python:3.11.6-slim-bookworm
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app.py .
COPY templates/ templates/
RUN mkdir -p /data
EXPOSE 9000
CMD ["python", "app.py"]
