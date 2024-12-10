From ubuntu:24.04

WORKDIR /mnt/cpack-exercise
# Install a few dependencies
RUN apt-get -qq update && \
    apt-get -qq -y install \
        build-essential \
        cmake \
        git \
        libboost-all-dev \
        wget \
        libdeal.ii-dev \
        vim \
        tree \
        lintian \
        unzip
        
# Get, unpack, build, and install yaml-cpp        
RUN mkdir software && cd software && \
    wget https://github.com/jbeder/yaml-cpp/archive/refs/tags/yaml-cpp-0.6.3.zip && unzip yaml-cpp-0.6.3.zip && \
    cd yaml-cpp-yaml-cpp-0.6.3 && mkdir build && cd build && \
    cmake -DYAML_BUILD_SHARED_LIBS=ON .. && make -j4 && make install    
    
# This is some strange Docker feature. Normally, you don't need to add /usr/local to these
ENV LIBRARY_PATH $LIBRARY_PATH:/usr/local/lib/
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/lib/
ENV PATH $PATH:/usr/local/bin/

COPY . .

#The commands build the code using cmake and make. It then installs and make the debian package 
RUN mkdir build && cd build \
    && cmake -DCMAKE_INSTALL_PREFIX:PATH=/mnt/cpack-exercise/cpackexample .. \ 
    && make -j \
    && make install \
    && make package \
    && apt install ./cpackexample-0.1.0-Linux.deb

RUN useradd -ms /bin/bash myuser

# Switch to the new user
USER myuser

CMD ["/bin/bash"]
