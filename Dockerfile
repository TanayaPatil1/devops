#base image
FROM ubuntu AS build
RUN apt-get update && apt-get install -y golang-go
ENV GO111MODULE=off
COPY . .
RUN CGO_ENABLED=0 go build -o /app .
# multistage
FROM scratch
#copying from binary build
COPY --from=build /app /app
#Set the entrypoint
ENTRYPOINT ["/app"]
