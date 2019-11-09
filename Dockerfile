FROM ubuntu:18.04

# Setting to flow without stopping when installing R
ENV DEBIAN_FRONTEND=noninteractive

# R installation. The latest version is included. The installation is done in a revolutionary way, forcing a number of errors to be ignored.
RUN apt-get update --fix-missing \
    && apt-get install -y --no-install-recommends \
    wget curl git gpg ca-certificates \
    && echo "deb https://cran.ism.ac.jp/bin/linux/ubuntu bionic/" | tee -a /etc/apt/sources.list \
    && gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 | true \
    && gpg -a --export E298A3A825C0D65DFD57CBB651716619E084DAB9 | apt-key add - | true \
    && apt update | true \
    && apt install r-base-core -y

#&& rm -rf /var/lib/apt/lists/* \

# If you downgrade R, put ver in x.x.x.
#RUN apt-get -y --allow-downgrades install r-base-core=x.x.x-1xenial0 \
#    && apt-get -y --allow-downgrades install r-base-dev=x.x.x-1xenial0 \
#    && apt-get -y --allow-downgrades install r-doc-html=x.x.x-1xenial0

# install packages
RUN Rscript -e 'install.packages("dplyr", repos="http://cran.ism.ac.jp/")'

CMD ["/bin/bash"]
