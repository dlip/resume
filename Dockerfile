FROM ubuntu:bionic

RUN apt update -y

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Australia/Sydney
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt install -y make curl

RUN curl -OL https://github.com/jgm/pandoc/releases/download/2.7.2/pandoc-2.7.2-1-amd64.deb && \
    apt install -y ./pandoc-2.7.2-1-amd64.deb && \
    rm -f pandoc-2.7.2-1-amd64.deb


RUN apt install -y texlive-xetex

# RUN apt install -y texlive-latex-recommended texlive-xetex texlive-luatex pandoc-citeproc texlive-latex-extra context wkhtmltopdf

WORKDIR /build
CMD ["make"]