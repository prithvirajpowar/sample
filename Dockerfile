# Base image
FROM ubuntu:latest

# Install required packages
RUN apt-get update && \
    apt-get -y install curl git unzip xz-utils zip libglu1-mesa openjdk-11-jdk

# Create a new user
RUN adduser --disabled-password --gecos '' myuser

# Set the working directory
WORKDIR /app

# Set the owner of the app directory to the new user
RUN chown -R myuser:myuser /app

# Switch to the new user
USER myuser

# Install Flutter SDK
RUN git clone https://github.com/flutter/flutter.git -b stable --depth 1 && \
    export PATH="$PATH:/app/flutter/bin" && \
    flutter precache && \
    flutter doctor

# Set environment variables
ENV PATH="${PATH}:/app/flutter/bin"

# Copy source code
COPY . /app

# Install dependencies
RUN flutter pub get

# Build the app
RUN flutter build apk

# Run the app
CMD ["flutter", "run"]
