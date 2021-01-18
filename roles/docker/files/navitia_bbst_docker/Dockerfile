FROM debian:buster

ENV TZ=Europe/Paris
RUN rm -f /etc/localtime && ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime

# stretch backport for libpqxx 4 for backward compatibility
RUN echo 'deb http://deb.debian.org/debian stretch-backports main contrib non-free' > /etc/apt/sources.list.d/backports.list
RUN cat /etc/apt/sources.list.d/backports.list
#RUN apt-get -y -t buster-backports install libpqxx-dev

RUN apt-get update
RUN apt-cache -t stretch-backports search pqxx

# install docker
RUN apt install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

RUN apt-get update
RUN apt install -y docker-ce

RUN	apt-get install -y \
		git \
        curl \
		postgresql-server-dev-all \
		python-dev \
		python3.7-dev \
		2to3 \
		libzmq3-dev \
		debhelper \
		build-essential \
		cmake \
		gcc \
		g++ \
		libboost-all-dev \
        liblog4cplus-1.1-9 \
		liblog4cplus-dev \
		libprotobuf-dev \
		protobuf-compiler \
		libproj13 \
		libproj-dev \
		libpqxx-dev \
		rabbitmq-server \
		libgeos-c1v5 \
		libgoogle-perftools4 \
		libgoogle-perftools-dev \
		sudo \
		vim \
        libosmpbf-dev \
        python-protobuf \
        clang-format-6.0 \
        libssl-dev && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# we can't use pip from system it's too old
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python get-pip.py \
    && pip install -U virtualenv pipenv && \
	# install dependancies for libc
	pip install ujson==1.33 numpy==1.9 && \
	rm -rf /tmp/* /var/tmp/* ~/.cache/pip/*

# add bbrisset user with sudo
RUN adduser --disabled-password --gecos '' bbrisset
RUN usermod -aG sudo bbrisset

RUN echo "root:root" | chpasswd

# bash tunning
RUN rm -f /home/bbrisset/.bashrc 
COPY .bashrc /home/bbrisset/.bashrc

# python jormun requirements
COPY requirements.txt /home/bbrisset/requirements.txt
COPY requirements_dev.txt /home/bbrisset/requirements_dev.txt
# python tyr requirements
COPY requirements_tyr.txt /home/bbrisset/requirements_tyr.txt
COPY requirements_dev_tyr.txt /home/bbrisset/requirements_dev_tyr.txt
# python pre-commits w requirements
COPY requirements_pre-commit.txt /requirements_pre-commit.txt

# pip jormun
RUN pip install -r /home/bbrisset/requirements_dev.txt
# pip tyr
RUN pip install -r /home/bbrisset/requirements_dev_tyr.txt

# remove useless requirements
RUN rm -f /home/bbrisset/requirements.txt /home/bbrisset/requirements_dev.txt
RUN rm -f /home/bbrisset/requirements_tyr.txt /home/bbrisset/requirements_dev_tyr.txt
RUN rm -f /requirements_pre-commit.txt

 
RUN export JORMUNGANDR_BROKER_URL='amqp://guest:guest@rabbitmq:5672//'
RUN export KRAKEN_RABBITMQ_HOST='rabbitmq'
RUN export NAVITIA_CHAOS_DUMP_PATH='/home/bbrisset/dev/navitia/source/tests/chaos/chaos_loading.sql.gz'

