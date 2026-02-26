#Create a Docker image to run a container as non-root user
#Method - 1
FROM alpine
WORKDIR /app
RUN addgroup -S appgroup #addgroup and adduser in alpine and -S means creates system user used for running services and applications and they dont have home directory.
RUN adduser -S appuser -G appgroup
RUN chown -R appuser:appgroup /app
USER appuser #used to switch the user
CMD ["sh","-c","whoami && id"]

#Method - 2
FROM ubuntu
WORKDIR /app
RUN groupadd appgroup #groupadd and useradd is present in ubuntu
RUN useradd -m appuser -G appgroup  #creates home directory
RUN chown -R appuser:appgroup /app
USER appuser
CMD ["sh","-c","whoami && id && echo $HOME"]
