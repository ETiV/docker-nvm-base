## The Docker Image etiv/nvm-base Dockerfile

This repository contains **Dockerfile** of [nvm](https://github.com/creationix/nvm) (Node.js Version Manager) and a simple `node-project` for running / testing apps on versions of Node.js.

### Dependencies

* [ubuntu:latest](https://registry.hub.docker.com/_/ubuntu/)

### Installation

* Install [Docker](https://www.docker.io/).
* You can choose by your situation:
    * If you already have [ubuntu:latest](https://registry.hub.docker.com/_/ubuntu/) on your system, just run:

    ```
    git clone https://github.com/ETiV/docker-nvm-base.git && \
    cd docker-nvm-base && \
    docker build -t etiv/nvm-base .\
    ```

    * If you're new to Docker, and don't have a [ubuntu:latest](https://registry.hub.docker.com/_/ubuntu/) image. Directly Install from Docker Hub:

    ```
    docker pull etiv/nvm-base
    ```

### Notice the Environment Variable

[etiv/nvm-base](https://registry.hub.docker.com/u/etiv/nvm-base/) uses an environment variable `NODE_VER` to specify which version of Node.js to be used.

Currently, `NODE_VER` is set to `0.10` by default.

So the `nvm` will automaticlly download and install the latest version in `0.10` _(Currently `0.10.30`)_ of Node.js when startup the container.

To manually specify which version of Node.js to be used, assign `NODE_VER` to the value you desired in command line.

i.e. `docker run -i -t -e NODE_VER=0.11 etiv/nvm-base` will download and use the latest Node.js `0.11.x`.

### Usage

#### - Start a bash

The container will run `bash` as the default command _(`CMD`)_.

So just run:

`docker run -ti etiv/nvm-base`

This will download and use the latest version of `0.10` of Node.js, and bring you to the `bash` shell with the installed Node.js.

#### - Run any other commands

The container will receive commands as a string, which will passed to `/bin/bash --login -i -c` _(`ENTRYPOINT`)_.

So the last argument of the command `docker run [anything] etiv/nvm-base 'last argument'` **MUST BE A QUOTED STRING**.

Otherwise, the command will not be executed correctly.

For examples:

- Installing `uglify-js` to global environment:

    `docker run -d etiv/nvm-base 'npm install -g uglify-js'`

- Running Node.js application in directory:

    `docker run -d etiv/nvm-base 'cd /root/node-project/ ; npm install && node app.js'`

  OR

    `docker run -d -w /node-project etiv/nvm-base 'npm install && node app.js'`

### A Tiny Project For Testing

There is a simple Node.js project called `node-project` comes with git source, for testing purpose.

To use it, `cd docker-nvm-base`, then run the following command:

```
docker logs -f $(\
  docker run -d \
  -e NODE_VER=0.10.28 \
  -p 3000:3000 \
  -v `pwd`/node-project:/node-project \
  -w /node-project \
  etiv/nvm-base 'npm install && node app.js'\
)
```

    This command will take port `3000` for listening.
    So make sure there is not any other applications has listened on this port.
    Or you should change the first `3000` to any other value between 1024 and 65535.

You'll see the outputs like this:
```
bash: cannot set terminal process group (-1): Inappropriate ioctl for device
bash: no job control in this shell
stdin: is not a tty
Installing node@0.10.28, this may take several minutes...
######################################################################## 100.0%
Now using node v0.10.28
default -> 0.10.28 (-> v0.10.28)
Install node@0.10.28 finished.
npm WARN package.json node-project@0.0.0 No repository field.
npm WARN package.json node-project@0.0.0 No README data
Server Started ... Access through: http://127.0.0.1:3000/
Node.js Version: v0.10.28
0 'Server is alive ... to test, run `curl http://127.1:3000/`'
... ...
```

Now you can `curl http://127.0.0.1:3000/` to access the application.

You'll get "Hello World" returned.

    If you have changed the port `3000` in the above command, use the new port instead of `3000` here.

You may also have noticed the line `Node.js Version: v0.10.28`.

Here the version is speicfied by `docker run` argument `-e NODE_VER=0.10.28`.

### EOF, Thanks For Reading
