FROM openjdk:11-jre-slim

WORKDIR /app

COPY build/app/outputs/apk/release/app-release.apk .

RUN apt-get update && \
    apt-get install -y curl && \
    curl -s "https://get.sdkman.io" | bash && \
    /bin/bash -c "source /root/.sdkman/bin/sdkman-init.sh && sdk install kotlin && sdk install gradle" && \
    apt-get remove -y curl && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN /bin/bash -c "source /root/.sdkman/bin/sdkman-init.sh && \
    mkdir -p src/main/java && \
    echo \"object Main {\" > src/main/java/Main.kt && \
    echo \"    @JvmStatic\" >> src/main/java/Main.kt && \
    echo \"    fun main(args: Array<String>) {\" >> src/main/java/Main.kt && \
    echo \"        println(\\\"Hello World!\\\");\" >> src/main/java/Main.kt && \
    echo \"    }\" >> src/main/java/Main.kt && \
    echo \"}\" >> src/main/java/Main.kt && \
    echo \"import org.junit.Test\" > src/test/java/ExampleUnitTest.kt && \
    echo \"import org.junit.Assert.*\" >> src/test/java/ExampleUnitTest.kt && \
    echo \"class ExampleUnitTest {\" >> src/test/java/ExampleUnitTest.kt && \
    echo \"    @Test\" >> src/test/java/ExampleUnitTest.kt && \
    echo \"    fun addition_isCorrect() {\" >> src/test/java/ExampleUnitTest.kt && \
    echo \"        assertEquals(4, 2 + 2)\" >> src/test/java/ExampleUnitTest.kt && \
    echo \"    }\" >> src/test/java/ExampleUnitTest.kt && \
    echo \"}\" >> src/test/java/ExampleUnitTest.kt && \
    ./gradlew build"

CMD ["java", "-jar", "build/libs/app.jar"]
