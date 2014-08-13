# DOCKER-VERSION ~1.1.0
FROM ubuntu

# setup base system
COPY apt.sources.list /etc/apt/sources.list
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qy build-essential libssl-dev git man curl

USER root
ENV HOME /root
ENV NODE_VER v0.10

# setup the nvm environment
RUN git clone https://github.com/creationix/nvm.git $HOME/.nvm
RUN echo '\n#The Following loads nvm, and install Node.js which version is assigned to $NODE_ENV' >> $HOME/.profile
RUN echo '. ~/.nvm/nvm.sh' >> $HOME/.profile
RUN echo 'echo "Installing node@${NODE_VER}, this may take several minutes..."' >> $HOME/.profile
RUN echo 'nvm install ${NODE_VER}' >> $HOME/.profile
RUN echo 'nvm alias default ${NODE_VER}' >> $HOME/.profile
RUN echo 'echo "Install node@${NODE_VER} finished."' >> $HOME/.profile
ENTRYPOINT ["/bin/bash", "--login", "-i", "-c"]
CMD ["bash"]
