# mkdocs

Docker container for creating a static site generator from Markdown format using [MkDocs](https://www.mkdocs.org/).

## Getting Started

### Prerequisites

 | Software | Version |
 |---------| --------|
 | [docker](https://docs.docker.com/get-docker/) | 19.3.0  |
 | [git](https://git-scm.com/downloads) |   |

### Basic verification of requirements

```{bash}
docker --version
git --version
docker pull mcr.microsoft.com/mcr/hello-world
```

### Installing and running

Build

```{bash}
git clone https://github.com/gehorak/mkdocs.git
cd ./mkdocs
docker build -t gehorak/mkdocs .
```

## Usage

### Start built-in dev-server

```{bash}
docker run --rm -it -p 8000:8000 -v ${PWD}:/mkdocs gehorak/mkdocs
```

### Build documentation

```{bash}
docker run --rm -it -v ${PWD}:/docs squidfunk/mkdocs-material build
```

## Provided interface of services

| Container | Port                            | Protocol | Credentials | Utilization |
|-----------|---------------------------------|----------|-------------|-------------|
| mkdocs    | [8000](https://localhost:8000/) | http     | ---         | mkdocs      |

## Reference

### Official Docker images

| Docker Image  | Utilization |
|---------------|-------------|
| python:alpine | base image  |

### Software

| Software                                                        | Version | Language | Official source of code                        | Utilization |
|-----------------------------------------------------------------|---------|----------|------------------------------------------------|-------------|
| [mkdocs](https://www.mkdocs.org/)                               |         | Python   | <https://github.com/mkdocs/mkdocs>             |             |
| [mkdocs-material](https://squidfunk.github.io/mkdocs-material/) |         | Python   | <https://github.com/squidfunk/mkdocs-material> |             |

### Resources

[MkDocs](https://www.mkdocs.org/)  
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
