FROM ubuntu:latest

# Set environment variables
ENV ANDROID_HOME=/opt/android-sdk-linux \
    PATH=${PATH}:/opt/android-sdk-linux/platform-tools:/opt/android-sdk-linux/tools/bin \
    DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    unzip \
    xz-utils \
    openjdk-11-jdk \
    libc6-i386 \
    lib32stdc++6 \
    lib32gcc1 \
    lib32ncurses5 \
    lib32z1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Download and install Android SDK
RUN curl -s https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip --output commandlinetools-linux.zip \
    && mkdir -p ${ANDROID_HOME}/cmdline-tools \
    && unzip commandlinetools-linux.zip -d ${ANDROID_HOME}/cmdline-tools \
    && rm commandlinetools-linux.zip \
    && yes | ${ANDROID_HOME}/cmdline-tools/tools/bin/sdkmanager --licenses \
    && ${ANDROID_HOME}/cmdline-tools/tools/bin/sdkmanager "platform-tools" "build-tools;30.0.3" "extras;android;m2repository" "extras;google;m2repository" "emulator" \
    && rm -rf ${ANDROID_HOME}/cmdline-tools/tools/bin/sdkmanager /root/.android \
    && chmod -R 777 ${ANDROID_HOME}

# Set up workspace
RUN mkdir -p /app
WORKDIR /app

# Copy project files
COPY . .

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git -b stable --depth 1 \
    && export PATH="$PATH:`pwd`/flutter/bin" 
    

# Build app
RUN flutter pub get \
    && flutter build apk --release

# Run app
CMD ["flutter", "run", "--no-sound-null-safety"]
