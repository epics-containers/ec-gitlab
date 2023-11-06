# start with the latest podman image
FROM quay.io/podman/stable AS developer
# TODO remove above and replace with just runtime (requires a new release of ec)
FROM developer AS runtime

COPY requirements.txt /requirements.txt

# add requirements for building Generic IOC containers
RUN yum install git pip wget -y
RUN pip install -r /requirements.txt

RUN wget -qO /usr/bin/yajsv https://github.com/neilpa/yajsv/releases/download/v1.4.1/yajsv.linux.amd64
RUN chmod a+x /usr/bin/yajsv

ENTRYPOINT /bin/bash

