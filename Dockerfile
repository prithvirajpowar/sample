# Set base image
FROM ubuntu:latest

# Update packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl git unzip xz-utils zip libglu1-mesa openjdk-8-jdk wget

# Set Flutter SDK path
ENV FLUTTER_HOME="/flutter"

# Install Flutter SDK
RUN git clone https://github.com/flutter/flutter.git ${FLUTTER_HOME} && \
    ${FLUTTER_HOME}/bin/flutter --version

# Set Flutter and Dart binaries in path
ENV PATH="${PATH}:${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin"

# Install dependencies
RUN flutter pub get

# Copy source code
COPY . .

# Build release version
RUN flutter build apk --release

# Set entry point
ENTRYPOINT ["flutter", "run"]

