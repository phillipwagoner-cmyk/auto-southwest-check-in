FROM python:3.12-rc-alpine

WORKDIR /app

ENV AUTO_SOUTHWEST_CHECK_IN_DOCKER=1

RUN apk add --update --no-cache chromium chromium-chromedriver xvfb xauth

RUN adduser -D auto-southwest-check-in -h /app
RUN chown -R auto-southwest-check-in:auto-southwest-check-in /app
USER auto-southwest-check-in

COPY requirements.txt ./
RUN pip3 install --upgrade pip && pip3 install --no-cache-dir -r requirements.txt && rm -rf /app/.cache

COPY . .

ENTRYPOINT ["python3", "-u", "southwest.py"]

# <-- Add this CMD line so the container doesn't fail when no arguments are provided
CMD ["--help"]

