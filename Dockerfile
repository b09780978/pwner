FROM b09780978/baseimage:16.04
MAINTAINER faker <b09780978@gmail.com>

WORKDIR /root

# Update and upgrade system.
RUN apt-get update \
&&  apt-get dist-upgrade -y

# Add package for gdb to debug on dirrderent arch .
RUN apt-get install -y binutils gcc-multilib \
&& apt-get install -y gdb-multiarch \
&& apt-get install -y ltrace strace \
&& apt-get install -y make nasm nmap

# Install gdb-peda and Pwngdb and qira.
RUN git clone https://github.com/longld/peda.git ~/peda \
&&  echo "source ~/peda/peda.py" >> ~/.gdbinit \
&&  git clone https://github.com/scwuaptx/Pwngdb.git \
&&  cp ~/Pwngdb/.gdbinit ~/ 

# Install pwntools.
RUN apt-get install python-dev libssl-dev libffi-dev build-essential -y \
&& pip2 install pwntools \
&& pip2 install -U pwntools

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
