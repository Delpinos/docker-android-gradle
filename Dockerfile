
FROM openjdk:8-jdk

LABEL Author="Alef Delpino"
LABEL Email="alef@delpinos.com"

ENV SDK_HOME="/usr/local"
ENV BUILD_DIR="/opt/workspace"
ENV ANDROID_HOME="/android-sdk-linux"
ENV ANDROID_TARGET_SDK="android-28"
ENV ANDROID_BUILD_TOOLS="28.0.3"
ENV ANDROID_SDK_TOOLS="4333796"
ENV ANDROID_SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip"
ENV GRADLE_VERSION="6.8.1"
ENV GRADLE_SDK_URL="https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip"
ENV GRADLE_HOME="${SDK_HOME}/gradle-${GRADLE_VERSION}"

RUN apt-get -qq update && apt-get install -y --no-install-recommends \
    lib32stdc++6 \
    lib32z1 \
    libqt5widgets5 \
    unzip \
    usbutils \
    tar \
    wget

WORKDIR /tmp

RUN curl -sSL "${GRADLE_SDK_URL}" -o gradle-${GRADLE_VERSION}-bin.zip  \
	&& unzip gradle-${GRADLE_VERSION}-bin.zip -d ${SDK_HOME}  \
	&& rm -rf gradle-${GRADLE_VERSION}-bin.zip

RUN curl -sSL "${ANDROID_SDK_URL}" -o android-sdk-linux.zip \
    && unzip android-sdk-linux.zip -d $ANDROID_HOME \
    && rm -rf android-sdk-linux.zip

RUN mkdir -p ~/.android && touch ~/.android/repositories.cfg

RUN mkdir -p $ANDROID_HOME/licenses && \
    echo "8933bad161af4178b1185d1a37fbf41ea5269c55" > $ANDROID_HOME/licenses/android-sdk-license && \
    echo "d56f5187479451eabf01fb78af6dfcb131a6481e" >> $ANDROID_HOME/licenses/android-sdk-license && \
    echo "84831b9409646a918e30573bab4c9c91346d8abd" > $ANDROID_HOME/licenses/android-sdk-preview-license

ENV PATH="${SDK_HOME}/bin:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:$PATH"

RUN echo yes | $ANDROID_HOME/tools/bin/sdkmanager --licenses && \
    echo yes | $ANDROID_HOME/tools/bin/sdkmanager "tools" "platform-tools" "emulator" && \
    echo yes | $ANDROID_HOME/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}" && \
    echo yes | $ANDROID_HOME/tools/bin/sdkmanager "platforms;${ANDROID_TARGET_SDK}" && \
    echo yes | $ANDROID_HOME/tools/bin/sdkmanager "extras;android;m2repository" "extras;google;google_play_services" "extras;google;m2repository" && \
    echo yes | $ANDROID_HOME/tools/bin/sdkmanager "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.2" && \
    echo yes | $ANDROID_HOME/tools/bin/sdkmanager "extras;m2repository;com;android;support;constraint;constraint-layout-solver;1.0.2"

WORKDIR $BUILD_DIR

CMD ["/bin/sh -c", "./gradlew build"]