FROM httpd:2.2

COPY /home/ec2-user/project/web/  /usr/local/apache2/htdocs/

CMD ["httpd-foreground"]
