FROM nginx

COPY watch-and-run.sh /

RUN chmod +x /watch-and-run.sh

CMD /watch-and-run.sh
