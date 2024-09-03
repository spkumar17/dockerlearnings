FROM ubuntu:latest

LABEL Name="Prasannakumar"

ENV AWS_ACCESS_KEY_ID=SDFSDFSDFSDFSDFSDFSDFSDF \
    AWS_SECRET_KEY_ID=SDSDSDSDSDSDSDSDSDSDSDSD \
    AWS_DEFAULT_REGION=US-EAST-1A

RUN apt update && apt install -y jq net-tools curl wget unzip \
    && apt install -y nginx iputils-ping

ARG T_VERSION='1.6.6'
ARG P_VERSION='1.8.0'

EXPOSE  8080

RUN wget https://releases.hashicorp.com/terraform/${T_VERSION}/terraform_${T_VERSION}_linux_amd64.zip \
    && wget https://releases.hashicorp.com/packer/${P_VERSION}/packer_${P_VERSION}_linux_amd64.zip \
    && unzip terraform_${T_VERSION}_linux_amd64.zip \
    && unzip packer_${P_VERSION}_linux_amd64.zip \
    && chmod 777 terraform \
    && chmod 777 packer \
    && ./terraform version \
    && ./packer version

WORKDIR /app

COPY ./cmdendpointdemo .  

ADD https://releases.hashicorp.com/terraform/${T_VERSION}/terraform_${T_VERSION}_linux_amd64.zip .

CMD ["nginx","-g","daemon off;"]



# ---

# FROM ubuntu:latest

# # Set the working directory in the image
# WORKDIR /app

# # Copy the files from the host file system to the image file system
# COPY . /app

# # Install the necessary packages
# RUN apt-get update && apt-get install -y python3 python3-pip

# # Set environment variables
# ENV NAME World

# # Run a command to start the application
# CMD ["python3", "app.py"]

# ----------------
# FROM ubuntu:latest

# LABEL Name="Prasannakumar"

# # Install necessary packages including iputils-ping
# RUN apt update && apt install -y jq net-tools curl wget unzip nginx iputils-ping

# # Use the CMD instruction to run the ping command
# CMD ["ping", "-c4", "www.youtube.com"]

    
# FROM ubuntu:latest

# LABEL Name="Prasannakumar"

# # Install necessary packages including iputils-ping
# RUN apt update && apt install -y jq net-tools curl wget unzip nginx iputils-ping

# # Use the CMD instruction to run the ping command
# ENTRYPOINT ["ping", "-c4", "www.youtube.com"]

