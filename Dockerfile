FROM alpine:3.18.3
RUN apk add --no-cache coreutils gcc libc-dev make nasm python3
WORKDIR /opt/test-runner
COPY bin/run.sh bin/
COPY process_results.py ./
COPY debug.asm ./
ENTRYPOINT ["/opt/test-runner/bin/run.sh"]
