FROM	        	--->Sets the base image.
WORKDIR		--->Sets the working directory for next instructions.
LABEL	 		--->Adds metadata (e.g., author info, description).
ENV	 		--->Sets environment variables
ARG        		--->Declares variables used during build (not available at runtime).
EXPOSE	 		--->Tells Docker which port the app will listen on (for documentation).
COPY			--->Copies files from the host machine to the image.
ADD			--->Like COPY, but supports URLs and auto-extracts archives.
RUN 			--->run shell commands like downloading, extracting, installing, etc.
CMD			--->Defines the default command to run when the container starts. we can change the CMD will running the image
ENTRYPOINT 	--->Defines the main process. Often used with CMD. More strict than CMD. we can change the  ENTRYPOINT using --entrypoint flag will running the image
.dockerignore   ---> (not a command but important) Works like `.gitignore` to skip files when building the image.
VOLUME              --->Creates a mount point with a specified path for persistent or shared data.
USER                     --->Sets the user for running commands and starting the container.                
HEALTHCHECK   --->Defines a command to check if the container is still healthy.  not check if container running or not.
ONBUILD             --->Adds trigger instructions for images that are used as a base in other builds.




If you declare VOLUME ["/data"] in your Dockerfile and run the container without specifying a volume, Docker will automatically create and attach an anonymous volume to /data. If you specify a volume at runtime, it overrides the Dockerfile’s volume instruction.
The HEALTHCHECK instruction tells Docker how to check if your container is “healthy” — meaning it’s running and functioning as expected.




Example:

FROM ubuntu
CMD ["echo ",  "Hello from CMD"]

docker run myimage
output:: "Hello from CMD"

docker run myimage echo Hello
output:: "Hello"

ENTRYPOINT

FROM ubuntu
ENTRYPOINT ["echo",  "Hello from CMD"]

docker run myimage
output:: "Hello from CMD"

docker run myimage echo Hello
output:: "echo Hello"

docker run --entrypoint ls myimage -la	
output:: 
total 8
drwxr-xr-x   1 root root 4096 Jul  7 00:00 .
drwxr-xr-x   1 root root 4096 Jul  7 00:00 ..



FROM ubuntu
VOLUME ["/data"]
CMD ["sleep", "3600"]

docker run -d --name test1 myimage  Run without volume (anonymous volume will be created and attach to /data path
docker run -d --name test2 -v mydata:/data myimage this will attach the volume mydata to /data path even if we not specify VOlUME in dockerfile


 
USER:
------
to make this work 

1️⃣ Create the user
You need to create a non-root user (e.g., appuser) inside the container:
RUN useradd -ms /bin/bash appuser

2️⃣ (Optional) Set a working directory
WORKDIR /home/appuser
3️⃣ Switch to that user
USER appuser


HEALTHCHECK
-----------------
FROM nginx:latest
# Healthcheck to see if nginx is responding
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost/ || exit 1

check health status in ---> docker inspect --format='{{json .State.Health}}' web


🧪 Example
🔹 Base image Dockerfile (Dockerfile.base):

FROM node:18
ONBUILD COPY . /app
ONBUILD RUN npm install

Build this:

docker build -t my-node-base -f Dockerfile.base .
🔹 Child image Dockerfile:

FROM my-node-base
CMD ["node", "index.js"]
When you build this child image:

docker build -t my-node-app .
The following is automatically triggered (thanks to ONBUILD):
COPY . /app
RUN npm install

