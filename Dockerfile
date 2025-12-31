FROM amazoncorretto:17 AS builder
WORKDIR /app

COPY gradle ./gradle
COPY gradlew ./gradlew
COPY build.gradle settings.gradle ./
RUN ./gradlew dependencies

COPY src ./src
RUN ./gradlew build

FROM amazoncorretto:17-alpine3.21
WORKDIR /app

COPY --from=builder /app/build/libs/*.jar /app/app.jar

ENTRYPOINT ["sh","-c","java $JVM_OPTS -jar /app/app.jar"]
