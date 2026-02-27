#Create a containerized Nginx website with custom HTML
FROM nginx
RUN rm /usr/share/nginx/html/index.html
COPY index.html /usr/share/nginx/html/index.html
CMD ["nginx","-g","daemon off;"]

#docker build -t mynginx .
#docker run -d -p 8080:80 mynginx #container port should be 80

#-g: stands for global directive this allows you to pass configuration instructions to nginx directly from cmd line.
#Normally nginx reads config from nginx.conf with -g you can ovverride without editing nginx.conf file.

#daemon off; By defualt nginx runs a daemon, meaning it forks itself to the background and the terminal/cmd finishes.
#In docker container stops when main process exits, to prevent this we use daemon off. this tells nginx stay in foreground,dont go in backgriund.
