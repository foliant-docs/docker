# Docker
Docker is a project that helps develop, update and publish Docker images for Foliant.

## Overview
There are four Docker images to build different versions of Foliant. 
This repo contains Dockerfiles to build each Docker image. 
Also,
each Dockerfile has its own build-and-publish script
to publish images to [Docker Hub](https://hub.docker.com/r/foliant/foliant/tags).

* `foliant/foliant:slim` — minimal image of Foliant core with no extensions.
  * [Dockerfile-slim](https://github.com/foliant-docs/docker/blob/master/Dockerfile-slim)
  * [build_slim.sh](https://github.com/foliant-docs/docker/blob/master/build_slim.sh)

* `foliant/foliant` — the default image with Foliant core and the `init` extension
  * [Dockerfile](https://github.com/foliant-docs/docker/blob/master/Dockerfile)
  * [build_latest.sh](https://github.com/foliant-docs/docker/blob/master/build_latest.sh)
* `foliant/foliant:pandoc` — the default image with foliantcontrib.pandoc and its dependencies:
TexLive and Pandoc for building PDF and DOCX
  * [Dockerfile-pandoc](https://github.com/foliant-docs/docker/blob/master/Dockerfile-pandoc)
  * [build_pandoc.sh](https://github.com/foliant-docs/docker/blob/master/build_pandoc.sh)
* `foliant/foliant:full` — the full image with all official Foliant extensions and third-party tools required for them to work
  * [Dockerfile-full](https://github.com/foliant-docs/docker/blob/master/Dockerfile-full)
  * [build_full.sh](https://github.com/foliant-docs/docker/blob/master/build_full.sh)

* [Makefile](https://github.com/foliant-docs/docker/blob/master/Makefile) needed to build Docker images on local computer

## Docker images dependencies

Docker images build with Dockerfiles based on a previous light version in the following order:
> Dockerfile-slim → Dockerfile → Dockerfile-pandoc → Dockerfile-full

It means that if you update `foliant/foliant:slim`, you should update all its dependants after:
`foliant/foliant` then `foliant/foliant:pandoc` then `foliant/foliant:full`. If you want to update `foliant/foliant`,
you should update `foliant/foliant:pandoc` then `foliant/foliant:full` etc.

### Which image to update?

* When [Foliant-core]((https://github.com/foliant-docs/foliant)) updates: 
   > update `foliant/foliant:slim` → `foliant/foliant` → `foliant/foliant:pandoc` → `foliant/foliant:full`

* When [foliantcontrib.init](https://github.com/foliant-docs/foliantcontrib.init) updates:
   > update `foliant/foliant` → `foliant/foliant:pandoc` → `foliant/foliant:full`

* When [foliantcontrib.pandoc](https://github.com/foliant-docs/foliantcontrib.pandoc) updates: 
   > update `foliant/foliant:pandoc` → `foliant/foliant:full`

* When any other Foliant extension updates: 
   > update `foliant/foliant:full` and [requirements.txt](https://github.com/foliant-docs/docker/blob/master/dependency_files/python_packages/requirements.txt) 
   > from `dependency_files/python_packages/requirements.txt`

## Update procedure
To update Docker-image on Docker Hub, you should:
1. Clone, pull or download this repo on your computer.
2. Update dependencies if needed.
3. Push changes to this repo.
4. Run a script which related to Docker-image you needed:

```bash
# In the project directory

./build_slim.sh    # for foliant/foliant:slim
./build_latest.sh  # for foliant/foliant
./build_pandoc.sh  # for foliant/foliant:pandoc
./build_full.sh    # for foliant/foliant:full
```

#### How to tag image (optional)
Scripts set tag for published image automatically. But you can tag the image manually as script parameter:
```bash
./build_full.sh 1.0.13
```

#### Docker Hub authorization
To push images to the [Foliant project on Docker Hub](https://hub.docker.com/r/foliant/foliant/), 
you should be logged in as **foliantshared**
