#Add healthcheck to dockerfile, verify container health status
FROM nginx
RUN rm /usr/share/nginx/html/index.html
COPY index.html /usr/share/nginx/html/index.html
HEALTHCHECK --interval=30s --timeout=5s --retries=3 CMD curl -f http://localhost/ || exit 1
CMD ["nginx","-g","daemon off;"]

#--interval=30s #how often docker checks the container(every 30secs)
#--timeout=5s #How long to wait for the check before considering it failed
#--retries=3 #No of consecutive failures before marking unhealthy
#curl http://localhost/ : to make http requests
#-f : fail silently; dont print any error
#exit 1: if command fail then exit status 1
