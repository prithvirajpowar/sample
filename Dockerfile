FROM cirrusci/flutter:latest

WORKDIR /app

COPY . .

# Install dependencies
RUN chown -R root:root .
USER cirrus
RUN flutter pub get

# Build the app
RUN flutter build apk --release

# Start the app
CMD ["flutter", "run"]
