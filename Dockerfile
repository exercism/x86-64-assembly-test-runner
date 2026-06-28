FROM alpine:3.23.5
RUN apk add --no-cache coreutils gcc libc-dev make nasm python3
WORKDIR /opt/test-runner
COPY bin/run.sh bin/
COPY process_results.py ./
COPY debug.mac ./
ENTRYPOINT ["/opt/test-runner/bin/run.sh"]
