FROM node:17 as builder

WORKDIR /usr
COPY app/package.json ./
COPY app/tsconfig.json ./
COPY app/src ./src
RUN ls -a
RUN npm install
RUN npm run build


FROM node:17 
WORKDIR /usr
COPY app/package.json ./
RUN npm install --only=production
COPY --from=0 /usr/dist .
RUN npm install pm2 -g
EXPOSE 3001
CMD ["pm2-runtime","index.js"]