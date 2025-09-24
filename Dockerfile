FROM python:3.12-rc-alpine

WORKDIR /app

# Define so the script knows not to download a new driver version
ENV AUTO_SOUTHWEST_CHECK_IN_DOCKER=1

# Install dependencies
RUN apk add --update --no-cache chromium chromium-chromedriver xvfb xauth

# Create a user
RUN adduser -D auto-southwest-check-in -h /app
RUN chown -R auto-southwest-check-in:auto-southwest-check-in /app
USER auto-southwest-check-in

# Copy Python requirements and install
COPY requirements.txt ./
RUN pip3 install --upgrade pip && pip3 install --no-cache-dir -r requirements.txt && rm -r /app/.cache

# Copy all code
COPY . .

# Set environment variable for the PORT Cloud Run will provide
ENV PORT 8080

# Start the script
ENTRYPOINT ["python3", "-u", "southwest.py"]



