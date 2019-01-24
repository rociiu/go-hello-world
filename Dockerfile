
############################
# STEP 1 build executable binary
############################
FROM golang:1.11.5 AS builder
# Install git.
# Git is required for fetching the dependencies.
# RUN apk update && apk add --no-cache git
COPY . /app/

WORKDIR /app

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o /go/bin/hello cmd/main.go

############################
# STEP 2 build a small image
############################
FROM scratch
# Copy our static executable.
COPY --from=builder /go/bin/hello /go/bin/hello

# Run the hello binary.
CMD [ "/go/bin/hello" ]

EXPOSE 80