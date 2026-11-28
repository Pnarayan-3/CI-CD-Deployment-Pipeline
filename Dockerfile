# Using a lightweight Nginx image
FROM nginx:alpine

# Upgrade Alpine packages to receive available security fixes
RUN apk upgrade --no-cache

# Copy application files into Nginx web root
COPY app/ /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
