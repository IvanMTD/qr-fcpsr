FROM alpine/git
WORKDIR /app
RUN git clone https://github.com/IvanMTD/qr-fcpsr.git

FROM maven
WORKDIR /app
COPY --from=0 /app/qr-fcpsr /app
RUN mvn clean package -DskipTests

FROM bellsoft/liberica-openjdk-alpine
EXPOSE 8090 8080
WORKDIR /app
COPY --from=1 /app/target/qr-1.0.0.jar /app
#CMD ["java","-Xms64m","-Xmx1000m","-jar","infosec-1.0.0.jar"]
CMD ["java","-jar","qr-1.0.0.jar"]