# JuliusVoiceAnalyzer
Using Julius developed by Kyoto University, we provide an environment and python program for voice recognition.

environment: mac(Catalina ver.10.15.4)

# Usage
First, install pulseaudio in local host.

```bash
$ brew install pulseaudio
```

And run pulse audio

```bash
$ pulseaudio --load=module-native-protocol-tcp --exit-idle-time=-1
```

Next, launch another terminal and start the docker container with the following command.

```bash
$ docker-compose up -d --build
```

Connect to the container with the following command.

```bash
$ docker-compose exec python bash
```

If you want to try Julius' voice recognition program, run the program with the following command.

```bash
$ cd opt/public/src
$ python3 VoiceAnalyzer.py
```

Or if you want to analyze file voice, run the following command.

```bash
$ bash julius-start.sh
...
enter filename->.'your file path'
```
※notification
Julius is only allowed rate 16000.

# VoiceAnalyzer.py

def __init__(self, chunk = 1024, format = pyaudio.paInt16, channels = 1, rate = 44100, record_seconds = 2, threshold = 0.1)

chunk: A collection of data in logical units of voice data  
format: Set phrase  
channels: Number of audio channels  
rate: Number of data samples to sample per second of audio  
record_seconds: Length to record(s)  
threshold: Loudness to start recording(0 ~ 1)  

def start_record(self, dir_name = '../sound/')  
Function to start recording  

dir_name: Destination directory name  
return value: Save file name  

def analyze_voice(self, file_path)  
A function that parses speech and returns what it says  

file_path: Audio data path.  
return value: Analysis result character string  