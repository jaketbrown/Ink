FROM swift:5.8-jammy as builder
ADD . /src
WORKDIR /src
RUN swift build -c release --product fuzz-ink -Xswiftc -sanitize=fuzzer,address

FROM swift:5.8-jammy-slim
COPY --from=builder /src/.build/release /release
COPY --from=builder /src/mayhem/testsuite /testsuite
ENV ASAN_OPTIONS detect_leaks=0
ENTRYPOINT ["/release/fuzz-ink", "/testsuite"]