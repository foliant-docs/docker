# Content

This repo contains:

1. Four Dockerfiles to build docker images:
    * Dockerfile-slim — minimal image of Foliant with no extensions
    * Dockerfile — the basic image with just Foliant core and the `init` command
    * Dockerfile-pandoc — basic image with the addition of TexLive and Pandoc for building PDF and DOCX
    * Dockerfile-full — the full image with all official Foliant extensions and third-party tools required for them to work
   
   
2. Each Dockerfile has it's own build-and-publish script to [Docker Hub:](https://hub.docker.com/r/foliant/foliant/tags)
   * build_slim.sh
   * build_latest.sh
   * build_pandoc.sh
   * build_full.sh


3. Makefile to build and test Foliant on local computer


4. dependency_files contains:
   * imagemagick
   * python_packages with requirements.txt (contains all packages for Foliant)

# Dockerfile dependencies

Docker images builds based on previous light version in the following order:
> Dockerfile-slim → Dockerfile → Dockerfile-pandoc → Dockerfile-full

It means that if you update Dockerfile-slim, you should update all its dependants after:
Dockerfile then Dockerfile-pandoc then Dockerfile-full. If you want to update Dockerfile,
you should update Dockerfile-pandoc then Dockerfile-full etc.

## Which image to update?

* When [Foliant-core]((https://github.com/foliant-docs/foliant)) updates: 
   > update Dockerfile-slim → Dockerfile → Dockerfile-pandoc → Dockerfile-full

* When [foliantcontrib.init](https://github.com/foliant-docs/foliantcontrib.init) updates:
   > update Dockerfile → Dockerfile-pandoc → Dockerfile-full

* When [foliantcontrib.pandoc](https://github.com/foliant-docs/foliantcontrib.pandoc) updates: 
   > update Dockerfile-pandoc → Dockerfile-full

* When any other Foliant extension updates: 
   > update Dockerfile-full and [requirements.txt](https://github.com/foliant-docs/docker/blob/master/dependency_files/python_packages/requirements.txt) 
   > from `dependency_files/python_packages/requirements.txt`

# Update procedure
To update Docker-image on Docker Hub you should:
1. Clone, pull or download this repo on your computer.
2. Update Docker-images you need.
3. Push changes to this repo.
4. Run script which related to Docker-image you updated:
```bash
# In the project directory

sh build_slim.sh    # for Dockerfile-slim
sh build_latest.sh  # for Dockerfile
sh build_pandoc.sh  # for Dockerfile-pandoc
sh build_full.sh    # for Dockerfile-full
```

### How to tag image (optional)
If you want to tag image, write its title after script:
```bash
sh build_full.sh 1.0.13
```

### Docker Hub authorization
To push images to [Foliant project on Docker Hub](https://hub.docker.com/r/foliant/foliant/), 
you should be logged in as **foliantshared**

## Project links
[Foliant-core repo](https://github.com/foliant-docs/foliant)

[Docker Hub repo with Foliant images](https://hub.docker.com/r/foliant/foliant)

[Foliant Documentation website](https://foliant-docs.github.io/docs/)

[foliantcontrib.init](https://github.com/foliant-docs/foliantcontrib.init)

[foliantcontrib.pandoc](https://github.com/foliant-docs/foliantcontrib.pandoc)