
.. |CSC_developer| replace::  Tiago Ribeiro
.. |CSC_product_owner| replace:: Tiago Ribeiro

.. Note that the "ts_" prefix is omitted from the title

#########################
Build Cycle
#########################

.. image:: https://img.shields.io/badge/GitHub-gray.svg
    :target: https://github.com/lsst-ts/ts_cycle_build
.. image:: https://img.shields.io/badge/Jira-gray.svg
    :target: https://jira.lsstcorp.org/issues/?jql=labels+%3D+ts_cycle_build
.. image:: https://img.shields.io/badge/Jenkins-gray.svg
    :target: https://tssw-ci.lsst.org/job/LSST_Telescope-and-Site/job/ts_cycle_build/

.. _Overview:

Overview
========

The Vera Rubin observatory control system is a highly coupled environment that requires strict management of the deployed software.
At the very least, we must keep an strict control over the core packages versions, to guarantee communication compatibility between components.

The core packages are:

  - ts_ddsconfig: Contains DDS Quality of Service (QoS) configuration and various sanctioned OpenSplice configuration options for running systems in shared memory, single process and unit testing.
  - ts_xml: Contains the interfaces definition of all components in the system.
  - ts_sal: Contains the core DDS communication middleware layer.
  - ts_idl: Contains ancillary files used by ts_salobj and other higher level applications.
  - ts_salobj: High-level Python library to develop CSCs and SAL Scripts.

In order to avoid conflicts the version of all these packages must be tightly controlled in production and test environments.
We accomplish this by introducing the concept of "cycle builds".
Each cycle is composed of a set of well defined software versions.
Every time a new set of core package versions is released, a new cycle must start.
In order to support software updates on a cycle, each cycle has a revision.
Any time a non-core package changes, without changing the version of core packages, a new revision is created.
Only those components that change in a new revision need to be rebuilt/redeployed.

The package ts_cycle_build is composed of a series of Dockerfiles that contain instructions on how to build the component docker containers.
The build is managed using docker-compose and an environment file which configures the build accordingly.

Containers are later deployed in a Kubernetes cluster, via puppet or docker-compose.
Details on deployment can be found elsewhere, this package mainly focuses on building deployment artifacts.

.. note::
  
  If you are interested in viewing other branches of this repository append a `/v` to the end of the url link. For example `https://ts_cycle_build.lsst.io/v/`


.. _User_Documentation:

User Documentation
==================

User-level documentation, found at the link below, is aimed at personnel looking to perform the standard use-cases/operations with the Build Cycle.
In this case, it involves building containers for a new cycle/revision for deployment at the summit or one of the test stands.

.. toctree::
    user-guide/*
    :maxdepth: 2
    :glob:

.. _Development_Documentation:

Development Documentation
=========================

This area of documentation focuses on the details of the container build scripts, and contains information on how to participate on the development of the Build Cycle.

.. toctree::
    developer-guide/developer-guide
    :maxdepth: 1

.. _Version_History:

Version History
===============

The version history of the Build Cycle is found at the following link.

.. toctree::
    version-history
    :maxdepth: 1
