##### build stage ##############################################################

FROM quay.io/podman/stable AS developer

RUN yum install pip -y
RUN pip install epics-containers-cli

##### runtime stage ############################################################

# we don't distinguish between developer and runtime stages for this container

FROM developer AS runtime

ENTRYPOINT /bin/bash

