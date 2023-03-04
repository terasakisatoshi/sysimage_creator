# Usage:
# $ docker build -t kyu . && docker run --rm -it -v $PWD:/work -w /work kyu /bin/bash -c "CI=true make && make test"

from julia:1.8.5

RUN apt-get update && apt-get install -y \
	build-essential \
	nano \
	unzip \
	xvfb \
	xauth
