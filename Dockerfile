# Base image with Flutter SDK
FROM cirrusci/flutter:stable AS build

# Set working directory
WORKDIR /app

# Copy the entire project
COPY . .

# Install dependencies
RUN flutter pub get

# Build the app
RUN flutter build apk

# Production image
FROM cirrusci/flutter:stable

# Set working directory
WORKDIR /app

# Copy built artifact from previous stage
COPY --from=build /app/build/app/outputs/flutter-apk/app-release.apk .

# Start the app
CMD ["flutter", "run", "--release"]
