# syntax=docker.io/docker/dockerfile:1
FROM mcr.microsoft.com/dotnet/aspnet:10.0-alpine3.24-arm64v8
WORKDIR /build
RUN <<HEREDOC
    apk add libmsquic dotnet10-sdk git curl

    git clone --depth 1 https://github.com/TechnitiumSoftware/TechnitiumLibrary.git TechnitiumLibrary
    git clone --depth 1 https://github.com/TechnitiumSoftware/DnsServer.git DnsServer

    dotnet build TechnitiumLibrary/TechnitiumLibrary.ByteTree/TechnitiumLibrary.ByteTree.csproj -c Release
    dotnet build TechnitiumLibrary/TechnitiumLibrary.Net/TechnitiumLibrary.Net.csproj -c Release
    dotnet build TechnitiumLibrary/TechnitiumLibrary.Security.OTP/TechnitiumLibrary.Security.OTP.csproj -c Release
    
    dotnet publish DnsServer/DnsServerApp/DnsServerApp.csproj -c Release
    mkdir /etc/dns
HEREDOC

RUN apk add -U --no-cache aspnetcore10-runtime libmsquic doggo

WORKDIR /opt/technitium/dns
COPY --link --from=build DnsServer/DnsServerApp/bin/Release/publish /opt/technitium/dns

ENTRYPOINT ["/usr/bin/dotnet", "/opt/technitium/dns/DnsServerApp.dll"]
CMD ["/etc/dns"]

EXPOSE \
  53/udp 53/tcp      \
  853/udp 853/tcp    \
  443/udp 443/tcp    \
  80/tcp 8053/tcp    \
  5380/tcp 53443/tcp \
  67/udp

LABEL org.opencontainers.image.title="Fork of Technitium DNS Server"
