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

RUN apt-get install -y sudo
RUN apt-get install -y vim
RUN apt-get install -y pulseaudio
RUN apt-get install -y build-essential curl file git
RUN useradd -m -s /bin/zsh linuxbrew && \
    usermod -aG sudo linuxbrew &&  \
    mkdir -p /home/linuxbrew/.linuxbrew && \
    chown -R linuxbrew: /home/linuxbrew/.linuxbrew
USER linuxbrew
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
USER root
ENV PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"

RUN brew install portaudio
RUN apt-get install -y python3 python-dev python3-dev \
     build-essential libssl-dev libffi-dev \
     libxml2-dev libxslt1-dev zlib1g-dev \
     python-pip python3-pip
RUN apt-get --assume-yes install libasound-dev portaudio19-dev     libportaudio2 libportaudiocpp0
RUN pip3 install --upgrade setuptools
RUN pip3 install gtts
RUN pip3 install pyaudio
RUN pip3 install pygame mutagen
RUN pip3 install numpy
RUN pip3 install SpeechRecognition

WORKDIR ~/opt/public/data
RUN apt-get install wget
RUN wget https://github.com/julius-speech/julius/archive/v4.4.2.tar.gz
RUN tar zxvf v4.4.2.tar.gz
WORKDIR ~/opt/public/data/julius-4.4.2
RUN ./configure
RUN make
RUN make install

RUN apt-get install unzip
WORKDIR ~/opt/public/data/julius-4.4.2/julius-kit
RUN wget https://github.com/julius-speech/grammar-kit/archive/v4.3.1.zip
RUN wget https://osdn.net/projects/julius/downloads/66544/dictation-kit-v4.4.zip
RUN unzip v4.3.1.zip
RUN unzip dictation-kit-v4.4.zip

RUN pip3 install matplotlib
RUN pip3 install scipy
RUN pip3 install pytz
RUN pip3 install geoip2
RUN pip3 install tqdm
RUN pip3 install geolite2
RUN pip3 install bs4
RUN pip3 install lxml
RUN pip3 install google-cloud-speech=1.1.0
RUN pip3 install googletrans

RUN apt install net-tools