FROM node

WORKDIR /app

COPY    . .

RUN npm install
RUN pwd 
RUN ls -la

HEALTHCHECK         \
  --interval=10s    \
  --timeout=3s      \
  --start-period=5s \
  --retries=3       \
  CMD curl -s -f -o /dev/null http://localhost:8090/ping || exit 1

EXPOSE  8090
CMD     [ "server.js" ]