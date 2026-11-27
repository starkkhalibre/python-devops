FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    procps \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt && rm -f /tmp/requirements.txt

RUN useradd --create-home --uid 1000 devops && chown -R devops:devops /workspace
USER devops

EXPOSE 8888

HEALTHCHECK --interval=15s --timeout=5s --start-period=10s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:8888/api')" || exit 1

CMD ["sh", "-c", "jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --IdentityProvider.token=\"${JUPYTER_TOKEN:-}\""]
