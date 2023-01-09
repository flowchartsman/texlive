# texlive-docker-multiarch

This repo defines a Docker image for using TeX Live 2022 to build documents on amd64 or arm64. It includes Pygments for using the `minted` package, and other tools as necessary. Please open an issue if something is missing.

It provides images for the `full` `medium` `basic` nd `minimal` schemes using the following tags:

* `flowchartsman/texlive-multiarch:full-latest`
* `flowchartsman/texlive-multiarch:medium-latest`
* `flowchartsman/texlive-multiarch:basic-latest`
* `flowchartsman/texlive-multiarch:minimal-latest`

Additionally, daily builds are automated to update all packages in each schema image using `tlmgr update --all`. These are tagged as:

* `flowchartsman/texlive-multiarch:*-daily`

## Integrations

This image is designed to provide an easy way to build projects without installing TeX Live locally, and this can be especially useful in an IDE, like VS Code, using [devcontainers](https://code.visualstudio.com/docs/devcontainers/containers). Instructions for doing this can be found in the `integrations` directory.

## Notes

TeX Live is installed using the [instructions on tug.org](https://tug.org/texlive/doc/install-tl.html), which place binaries in an architecture-specific directory under `/usr/local/texlive/2022/bin/<architecture>`. To make this work smoothly across architectures, this is symlinked to `/usr/local/texlive/2022/bin/docker`
