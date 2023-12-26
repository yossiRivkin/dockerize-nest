# build stage

FROM node:18-alpine as build

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build



# prod stage 
FROM node:18-alpine

WORKDIR /user/src/app

COPY --from=build /usr/src/app/dist ./dist

COPY package*.json ./

RUN npm install --only=production

RUN rm package*.json

EXPOSE 5200

CMD [ "node", "dist/main.js" ]