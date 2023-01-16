# Define the build stage
FROM python:3.11.1-alpine3.17 AS build

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install --trusted-host pypi.python.org --no-cache-dir -r /requirements.txt

# Use the build stage
FROM python:3.11.1-alpine3.17

COPY --from=build /py /py

ENV PYTHONUNBUFFERED 1
ENV PATH="/py/bin:$PATH"

WORKDIR /app

COPY ./app /app

EXPOSE 80

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]