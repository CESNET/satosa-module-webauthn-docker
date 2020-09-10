FROM debian:buster


RUN apt-get update && apt-get install -y --no-install-recommends curl wget git vim python3 python3-dev build-essential \
    libjpeg-dev libz-dev libffi-dev libssl-dev libxslt1-dev libpq-dev \
    libldap2-dev libsasl2-dev libmariadb-dev &&\
    apt-get -y install nano python3 python3-pip && \
    cd /var && \
    mkdir webauthn-module && \
    cd webauthn-module && \
    git clone https://github.com/CESNET/satosa-module-webauthn.git && \
    mv satosa-module-webauthn py_webauthn && \
    cd py_webauthn/app && \
    pip3 install -r requirements.txt && \
    #pip3 install flask && \
    #pip3 install flask-login && \
    #pip3 install cbor2 && \
    #pip3 install mysql-connector-python && \
    #pip3 install pyjwkest && \
    #pip3 install pyOpenSSL && \
    #pip3 install PyYAML && \
    export FLASK_APP=/var/webauthn-module/py_webauthn/app/app.py
EXPOSE 80
WORKDIR /var/webauthn-module/py_webauthn/app
CMD python3 create_db.py && python3 app.py
