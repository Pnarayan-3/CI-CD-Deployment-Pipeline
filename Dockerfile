# Using a lightweight Nginx image
FROM nginx:alpine

# Copy the application files into Nginx's web directory
COPY app/ /usr/share/nginx/html/

# Expose the HTTP port
EXPOSE 80

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
