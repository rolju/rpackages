FROM rocker/verse:latest

COPY requirements.txt .

# Systemabhängigkeiten aktualisieren
RUN apt-get update && apt-get upgrade -y

# Liste der R-Pakete installieren
RUN R -e "install.packages(readLines('requirements.txt'), repos='https://packagemanager.posit.co/cran/__linux__/noble/latest')"

# TinyTeX-Pakete installieren
RUN tlmgr update --self && \
    tlmgr install \
    collection-fontsrecommended \
    collection-latexrecommended \
    collection-luatex \
    babel-german \
    hyphen-german \
    csquotes \
    footmisc \
    caption \
    xcolor \
    booktabs \
    multirow \
    wrapfig \
    float \
    enumitem \
    pdflscape \
    tabu \
    varwidth \
    threeparttable \
    threeparttablex \
    environ \
    trimspaces \
    ulem \
    makecell \
    colortbl

# Setze POSIT Package Manager Repository für Ubuntu
RUN echo "options(repos = c(NEXUS = 'nexus.kubus-it.de/repository/r-proxy'))" >> /usr/local/lib/R/etc/Rprofile.site

# Aufräumen
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Arbeitsverzeichnis setzen
WORKDIR /home/rstudio

CMD ["/init"]
