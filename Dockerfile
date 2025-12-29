FROM python:3.9-slim

WORKDIR /app

# إضافة هذا السطر لتثبيت مكتبة Flask
RUN pip install flask

COPY hello.py .

# تأكدي أن المنفذ هو 5000
EXPOSE 5000

CMD ["python", "hello.py"]
