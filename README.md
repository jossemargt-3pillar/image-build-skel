# Image Builder Skel

This repository contains a utility that generates a git repository with all of the files necessary to build a Rancher k8s upstream dependency.

## Build

```sh
make
```

## Install

```sh
sudo make install
```

## Run

```sh
./image-build-skel rancher/fips-image-build-flannel
```

```sh
docker run --rm -v $PWD:$PWD -w $PWD rancher/image-build-skel:v0.1.0 rancher/fips-image-build-flannel
```

## License
Copyright (c) 2014-2020 [Rancher Labs, Inc.](http://rancher.com)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
