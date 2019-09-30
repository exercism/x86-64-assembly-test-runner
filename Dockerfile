FROM alpine:3.10
RUN apk add --no-cache gcc libc-dev make nasm
WORKDIR /opt/test-runner
COPY run.sh bin/
ENTRYPOINT ["/opt/test-runner/bin/run.sh"]
