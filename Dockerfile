FROM alpine:3.24.3@sha256:be2656061b536c1883c4034790e21d0a09c5aaaf51968b89368a3c0371ea2c9a
RUN apk add --no-cache coreutils gcc libc-dev make nasm python3
WORKDIR /opt/test-runner
COPY bin/run.sh bin/
COPY process_results.py ./
COPY debug.mac ./
ENTRYPOINT ["/opt/test-runner/bin/run.sh"]
