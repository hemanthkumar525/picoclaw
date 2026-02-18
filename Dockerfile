# ============================================================
# Stage 1: Build the picoclaw binary
# ============================================================
FROM golang:1.26.0-alpine AS builder

RUN apk add --no-cache git make

WORKDIR /src

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN make build

# ============================================================
# Stage 2: Runtime
# ============================================================
FROM alpine:3.23

RUN apk add --no-cache ca-certificates tzdata curl

COPY --from=builder /src/build/picoclaw /usr/local/bin/picoclaw
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
