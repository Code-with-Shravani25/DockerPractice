#Write a Dockerfile to run a simple shell scipt
FROM alpine
WORKDIR /app
COPY . .
RUN chmod +x script.sh
CMD ["./script.sh"] 
#if we just write "script.sh" then it wont understand or wont use current directory
