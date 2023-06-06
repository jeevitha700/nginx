FROM nginx:latest
COPY . /user/share/nginx/html
EXPOSE 80
CMD ["nginx","start"]
