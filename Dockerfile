# start with the latest podman image
FROM quay.io/podman/stable AS developer
# runtime and developer are the same image for this container
FROM developer AS runtime

# add requirements for building Generic IOC containers
RUN yum install git -y
RUN yum install pip -y
RUN pip install epics-containers-cli

ENTRYPOINT /bin/bash

