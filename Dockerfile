# Build phase


# tags a phase with a name. Sets the base image to use for any subsequent instructions that follow
# and also give this build stage a name 
FROM node:alpine as builder 

# specifies a work directory
WORKDIR '/app'

# copies over the file to the image's filesystem 
COPY package.json .
RUN npm install 

# copies all the sourcecode
COPY . .

# builds for production
RUN npm run build 

# Run phase

FROM nginx

# copies from the "builder" phase 
COPY --from=builder /app/build /usr/share/nginx/html