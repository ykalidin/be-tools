FROM ubuntu:20.10

RUN apt-get update -y && apt install curl dos2unix -y

COPY *.sh .
RUN chmod ugo+x *.sh && dos2unix *.sh

CMD ["/bin/bash"]