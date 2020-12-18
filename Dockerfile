FROM ubuntu:18.04
USER root

RUN apt-get update
RUN apt-get -y install locales && \
    localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
ENV TZ JST-9
ENV TERM xterm

RUN apt-get install -y sudo && \
    apt-get install -y vim && \
    apt-get install -y pulseaudio && \
    apt-get install -y build-essential curl file git && \
    useradd -m -s /bin/zsh linuxbrew && \
    usermod -aG sudo linuxbrew &&  \
    mkdir -p /home/linuxbrew/.linuxbrew && \
    chown -R linuxbrew: /home/linuxbrew/.linuxbrew
USER linuxbrew
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
USER root
ENV PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"

RUN brew install portaudio && \
    apt-get install -y python3 python-dev python3-dev \
    build-essential libssl-dev libffi-dev \
    libxml2-dev libxslt1-dev zlib1g-dev \
    python-pip python3-pip && \
    apt-get --assume-yes install libasound-dev portaudio19-dev     libportaudio2 libportaudiocpp0 && \
    pip3 install --upgrade setuptools && \
    pip3 install gtts && \
    pip3 install pyaudio && \
    pip3 install pygame mutagen && \
    pip3 install numpy && \
    pip3 install SpeechRecognition

WORKDIR /data
RUN pwd
RUN apt-get install wget && \
    wget https://github.com/julius-speech/julius/archive/v4.4.2.tar.gz && \
    tar zxvf v4.4.2.tar.gz
WORKDIR /data/julius-4.4.2
RUN pwd
RUN ./configure && \
    make && \
    make install

RUN apt-get install unzip
WORKDIR /data/julius-4.4.2/julius-kit
RUN wget https://github.com/julius-speech/grammar-kit/archive/v4.3.1.zip && \
    wget https://osdn.net/projects/julius/downloads/66544/dictation-kit-v4.4.zip && \
    unzip v4.3.1.zip && \
    unzip dictation-kit-v4.4.zip && \
    pip3 install matplotlib && \
    pip3 install scipy && \
    pip3 install pytz && \
    pip3 install tqdm && \
    pip3 install bs4 && \
    pip3 install lxml
