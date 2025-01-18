FROM python:3

# Allow statements and log messages to immediately appear in logs
ENV PYTHONUNBUFFERED True

EXPOSE 8080

# Set the working directory
ENV APP_HOME /app
WORKDIR $APP_HOME

# Copy local code to the container image
COPY . ./

# Install required dependencies
RUN apt-get update && apt-get install -y wkhtmltopdf
RUN which wkhtmltopdf && wkhtmltopdf --version

# Install Python dependencies
RUN pip install -r requirements.txt

# Command to start the app
CMD streamlit run --server.port 8080 --server.enableCORS false main.py

# For environments with multiple CPU cores, increase the number of workers
# to be equal to the cores available.
# Timeout is set to 0 to disable the timeouts of the workers to allow Cloud Run to handle instance scaling.
CMD streamlit run --server.port 8080 --server.enableCORS false main.py
