#Create a Dockerfile to run a simple Node.js
FROM alpine/git AS clone
WORKDIR /app
RUN git clone https://github.com/Code-with-Shravani25/Node-App-Code.git

FROM node:18
WORKDIR /app
COPY --from=clone /app/Node-App-Code/. .
RUN npm install
ENTRYPOINT ["node","app.js"]

#Run as: sudo docker run -d -p 3000:3000 <image>
