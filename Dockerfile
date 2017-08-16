FROM alpine:3.5
MAINTAINER Johannes Schickling "schickling.j@gmail.com"

ADD install.sh install.sh
RUN sh install.sh && rm install.sh
ADD run.sh run.sh
ADD backup.sh backup.sh

CMD ["sh", "run.sh"]