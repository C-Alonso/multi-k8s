# Use an existing docker image as base
FROM node:alpine as builder

# So the folders files copied on the next command are pasted on the specified directory (/app)
WORKDIR "/app"

# Download and install dependency. To run the npm install command, we only need the 'package.json' file.
COPY ./package.json ./
RUN npm install

# The ./ ./ means that everything from the simpleweb directory will be copied into the image.
# This way, we don't have to run the RUN npm install command each time that we change our files (f.e.: index.js).
COPY . .

# Tell the image what to do when it start as a container. This will create a build folder, which is the one we need for the next phase.
RUN npm run build

#Now we start with the second phase.
FROM nginx
EXPOSE 3000

#The start nginx command is added automatically.

# We overwrite the default.conf file that comes with the nginx image.
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf


COPY --from=0 /app/build /usr/share/nginx/html