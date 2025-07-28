# Telescope and Site Cycle build

This repository contains the scripts, ancillary configuration files and information to manage the cycle build for Telescope and Site components.

The cycle build repository is separated in two main sub-directories; cycle and build.

The `cycle` directory contains the build configurations whereas `build` will host the build files (e.g. Dockerfile).

The build process relies on docker-compose to configure the versions of the multiple packages for the cycle.
The version configuration is stored in the `cycle.env` file that is stored in the `~/cycle` folder, along with the `docker-compose.yaml` file.
The `cycle.env` file sets the values for the variables defined in the `docker-compose.yaml`.
When building using `docker-compose`, those variables will be replaced at run time.

For instance, at the top of `cycle.env` there is a definition of the build number, e.g.:

```
CYCLE=0010
```

That means, all occurrences of `${CYCLE}` in `docker-compose.yaml` will be replaced by the value in `cycle.env` (e.g. 0010).

## Architecture

To minimize duplication and facilitate the process, the build is distributed in several layers.
The "base" images contains the basic packages needed.
These images ship with OpenSplice (installed from RPMs) and salobj (installed from conda).
The next layers are usually installing the package and any other requirements on top of the base image.

### Development Environment

The development environment is a container packed with several packages useful to support development.
One special distinction between the Development and the Deployment environments is that the first is capable of building the SAL libraries, whereas the second is not.

### Community vs. Private editions

Builds for the basic deployment images are configured in two different modes; community and private.
These are related to the version of OpenSplice that ships with the images.
The community edition is public and is uploaded to the docker-hub registry (`lsstts`).
The private images ships with the latest version of OpenSplice, as well as with a host-free runtime library and a host-bound full license.

Private images are mainly provided for deployment at this stage and most users should mostly use the community edition for development.

Further details TBD.

# Build instructions

The first step in the build process is to identify the set of tags needed.
If any change is made to `cycle.env`, then a new cycle should be initiated and the value of `CYCLE` should be incremented.
Once `cycle.env` is prepared and the user has verified that all the packages exists, it is possible to start the build.
The build starts by building the base image.

```bash
docker-compose -f cycle/docker-compose.yaml --env-file cycle/cycle.env build deploy-conda-private
docker-compose -f cycle/docker-compose.yaml --env-file cycle/cycle.env push deploy-conda-private
docker-compose -f cycle/docker-compose.yaml --env-file cycle/cycle.env build deploy-lsstsqre-private
docker-compose -f cycle/docker-compose.yaml --env-file cycle/cycle.env push deploy-lsstsqre-private
```

Once the base deployment images are built you can build the CSCs that uses those base images.

We usually start with those images that use the ``deploy-env`` base image, which is a simple AlmaLinux8 image with a conda installation.

```bash
docker-compose --env-file cycle/cycle.env -f cycle/docker-compose.yaml build \
  ataos \
  atdome \
  atdometrajectory \
  athexapod \
  atmcs \
  atpneumatics \
  atspectrograph \
  genericcamera \
  hexapod \
  mtdome \
  mtdometrajectory \
  mtm2 \
  mtmount \
  ospl-daemon \
  rotator \
  watcher

docker-compose --env-file cycle/cycle.env -f cycle/docker-compose.yaml push \
  ataos \
  atdome \
  atdometrajectory \
  athexapod \
  atmcs \
  atpneumatics \
  atspectrograph \
  genericcamera \
  hexapod \
  mtdome \
  mtdometrajectory \
  mtm2 \
  mtmount \
  ospl-daemon \
  rotator \
  watcher

```

Next we build those images that use the ``deploy-sqre`` base image, which is based on ``lsstsqre/centos`` image, thus contains the DM stack with the TSS base software ``eups`` declared but installed as conda packages.

## Building the development environment

The development environment is broken down into three different builds.
A base build will add OpenSplice and several utility packages useful for development.
Then, salobj build adds the basic packages; ts_xml, ts_sal, ts_idl, ts_salobj and all the ts_config packages.
Finally, the develop-env build adds some useful packages needed for development, all the way to ts_scriptqueue.

The build should be done in the following order:

```bash
docker-compose -f cycle/docker-compose.yaml --env-file cycle/cycle.env build base-sqre-community
docker-compose -f cycle/docker-compose.yaml --env-file cycle/cycle.env build salobj-community
docker-compose -f cycle/docker-compose.yaml --env-file cycle/cycle.env build develop-env-community
```

Currently (2020/07/27) the develop-env image with the private version of DDS is not working.

# Version History

## Cycle 0009

First use of deployment cycle using xml 6.0.0, sal 4.1.4 and salobj 5.15.0.

## Cycle 0010

Updating deployment to use xml 6.1.0 and salojb 5.17.0.
Major updates to build and deploy containers with licensed version of OpenSplice and testing shared memory mode.
See tstn-023 for more details about shared memory mode and this cycle.

## Cycle 0011

Updating deployment to use disposable QoS for telemetry topics.
This is an experimental feature on sal/salobj to see if we alleviate the system dictionary by making telemetry disposable.
This experiment is part of a task to obtain a stable DDS deployment.

## Cycle 0012

Updating deployment to use new partitioning schema implemented in salobj 6/sal 5.
This is also an experimental feature in sal/salobj to try to improve the how data is organized in the DDS Global Data Storage.
This experiment is part of a task to obtain a stable DDS deployment.

## Cycle c0013

Continuing tests with salobj 6/sal 5.

## Cycle c0014

Official release of salobj 6/sal 5 with xml 6.1.0.

## Cycle c0015

Release of salobj 6/sal 5 with xml 6.2.0.

## Cycle c0016

Release of salobj 6/sal 5 with xml 7.0.0.

## Cycle c0017

Release of salobj 6/sal 5 with xml 7.1.0.

# Open questions

 * What is the criteria for a cycle build?
 * What things changing warrant a bump in the cycle build?
 * How do we handle updates to CSCs that don’t require SAL/XML changes?
 * How does that affect the cycle build?
