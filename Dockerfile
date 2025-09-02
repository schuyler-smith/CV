FROM texlive/texlive:latest-full

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      fonts-liberation fontconfig && \
    rm -rf /var/lib/apt/lists/*

COPY data/fonts /usr/share/fonts/opentype/custom/

RUN fc-cache -fv
