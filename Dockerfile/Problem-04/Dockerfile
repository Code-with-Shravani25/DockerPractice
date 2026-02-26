#ARG and ENV
FROM ubuntu
ARG APP_VERSION=1.0
ENV APP_ENV=Production
RUN echo "Building version:$APP_VERSION"
CMD ["sh","-c","echo Running version: $APP_VERSION && echo Enviornment: $APP_ENV"]
