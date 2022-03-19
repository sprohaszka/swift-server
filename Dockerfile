FROM swift:5.6.0

COPY . /app

#RUN apt-get -q install -y libcurl-devel

CMD swift /app/server/main.swift