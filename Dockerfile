FROM python:3.9

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    xvfb \
    x11vnc \
    fluxbox \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Set up VNC server
RUN mkdir ~/.vnc && \
    x11vnc -storepasswd 1234 ~/.vnc/passwd

# Start VNC server and application
CMD ["sh", "-c", "xvfb-run -a x11vnc -forever -usepw -create & python main.py"]