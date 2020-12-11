.. _Developer_Guide:

#########################################
Build Cycle Developer Guide
#########################################

Build cycle is designed to provide a simple way of building containers for deployment at the various locations; NCSA Test Stand (NTS), Tucson Test Stand (TTS), summit and others.
When contributing or interacting with this repository, developers may be interested in adding new docker build scripts (e.g. ``Dockerfile``) for a component or updating existing scripts.
This document contains relevant information to help users accomplish this and other maintenance tasks.

The build is modeled on top of the ``docker-compose`` build infrastructure.
This allows us to specify services with build configuration in a ``yaml`` file.
It is also possible to specify dependencies for each service, though we found the interface for building a bit lacking and avoided using it at this time.
The build configuration is stored in the ``cycle/docker-compose.yaml`` file.
There, one can find the name of the services and the input configuration for each build.

For example, the entry bellow shows the section for the base deployment image used for the majority of the systems.

.. code-block:: rst

    deploy-conda-private:
      image: ts-dockerhub.lsst.org/deploy-env:${CYCLE}
      build:
        context: ../build/
        dockerfile: ./deploy-env/conda/Dockerfile
        labels:
          com.description: "Base deployment image for cycle ${CYCLE}."
        args:
          dds_community_version: ${dds_community_version}
          dds_community_build: ${dds_community_build_el7}
          dds_private_version: ${dds_private_version}
          dds_private_build: ${dds_private_build}
          ts_salobj: ${ts_salobj}
          ts_dds: ${ts_dds_private}
          ts_idl: ${ts_idl}_${ts_xml}_${ts_sal}

The section is defined first by the name of the service, in this case, ``deploy-conda-private``, followed by the image name and the build section.
The build section contains parameters that are passed to the build.
As one can see above, most of the parameters are set with environment variables (e.g. ``${variable_name}``).
There are basically two ways of defining these variables; through an environment file or by setting them on the build environment.

In order to support a continuous build infrastructure for several different services we employ an environment file.
The file is located in ``cycle/cycle.env``, and contains values for all the variables specified in ``cycle/docker-compose.yaml``.
It is possible to override any of the values in the environment file by exporting an environment variable on the build environment.
For instance, if you do;

.. prompt:: bash

  export CYCLE=c0005-special

The value of ``CYCLE`` in ``cycle/cycle.env``, would be overridden by ``c0005-special`` above.

All ``Dockerfiles`` are located in sub-directories in the ``build`` directory.
In general, each sub-directory is named after the build which appears in the ``cycle/docker-compose.yaml`` file, though some have different names for maintenance purposes (like the base images which can be build for the community or licensed edition of ``OpenSplice``).

To add a new build to the cycle, create a sub-directory in the ``build`` directory and add the ``Dockerfile`` and ancillary scripts (e.g. startup scripts).
In general you would pick one of the available base images to build your component; ``deploy-env`` or ``base-sqre``.

The ``deploy-env`` image is a simple ``centos`` image with all the prerequisites required to run a CSC packed with conda whereas ``base-sqre`` is built on top of the ``lsstsqre/centos`` tailored for ``eups`` declarable CSCs.


(To be continued...)

.. _Building:

Building
========

In general users should rely on the `cycle build jenkins job`_ to execute builds.
Nevertheless, in some cases one may need to execute those locally for development, maintenance or customization purposes.

For instance, to build the ``deploy-conda-private`` locally one would do;

.. prompt:: bash

  git clone https://github.com/lsst-ts/ts_cycle_build.git
  cd ts_cycle_build/
  docker-compose -f cycle/docker-compose.yaml --env-file cycle/cycle.env build deploy-conda-private


.. _Dependencies:

Dependencies
============

* docker
* docker-compose

.. _Contributing:

Contributing
============

Code and documentation contributions utilize pull-requests on github.
Feature requests can be made by filing a Jira ticket with the `Build Cycle` label.
In all cases, reaching out to the :ref:`contacts for this CSC <CSC_developer>` is recommended.
