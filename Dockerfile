FROM alpine
RUN apk add musl-dev
RUN apk add gcc 
RUN apk add libcap-dev
RUN apk add -U libcap
WORKDIR /home/test
# RUN adduser -g -n "test" test
COPY docker_probe.c /home/test/docker_probe.c
# RUN chown -R test:test /home/test/docker_probe.c
RUN gcc -o /home/test/docker_probe /home/test/docker_probe.c -lcap
# RUN chown -R test:test /home/test/docker_probe
# USER test
RUN ["/home/test/docker_probe"]




