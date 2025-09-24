FROM python:3.12-rc-alpine

WORKDIR /app

# Avoid re-downloading Chrome driver
ENV AUTO_SOUTHWEST_CHECK_IN_DOCKER=1

# Install dependencies
RUN apk add --update --no-cache chromium chromium-chromedriver xvfb xauth bash

# Add user
RUN adduser -D auto-southwest-check-in -h /app
RUN chown -R auto-southwest-check-in:auto-southwest-check-in /app
USER auto-southwest-check-in

# Copy requirements and install
COPY requirements.txt ./
RUN pip3 install --upgrade pip && pip3 install --no-cache-dir -r requirements.txt && rm -rf /app/.cache

# Copy code
COPY . .

# Make script executable
RUN chmod +x southwest.py

# Use entrypoint to run the script
ENTRYPOINT ["python3", "-u", "southwest.py"]
