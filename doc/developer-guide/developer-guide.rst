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

.. _Developer_Guide_Adding_New_Components:

Adding New Components
=====================

The first step in adding a new component to the cycle build is to develop a ``Dockerfile`` with the instructions on how to build the container.

The process starts by selecting what kind of base image the component will be built on top of.
If the component contains a conda package, and does not have any dependency on the DM stack, then it should be built on top of the ``deploy-env`` image.
In this case the ``Dockerfile`` will start with the following lines:

.. code-block:: text

  ARG cycle
  ARG hub

  FROM ${hub}/deploy-env:${cycle}

If, on the other hand, the component is an ``eups`` package and/or has dependencies on the DM stack, it needs to be built on top of ``deploy-sqre``.
In this case the ``Dockerfile`` will start with the following lines:

.. code-block:: text

  ARG cycle
  ARG hub

  FROM ${hub}/deploy-sqre:${cycle}

In both cases, the instructions should be added to install the component in the container.

Finally, the component needs to be setup to run when the container runs.
Both base images are already pre-setup to run, with some additional steps to ensure that components attached to DDS daemons will not corrupt them when terminating.

To take advantage of this setup, users must first add a ``startup.sh`` file to their build directory.
This file must have the following format:

.. code-block:: text

  #!/usr/bin/env bash

  source $HOME/.setup_sal_env.sh

  <start_component_script> &

  pid="$!"

  wait ${pid}

Replacing ``<start_component_script>`` with the command that will start the component.
If the component needs additional setup it can be done in the same script, though the steps shown above are all mandatory and cannot be modified.

If the component requires input arguments we recommend adding the following to the ``Dockerfile``;

.. code-block:: text

  ENV RUN_ARG=""

and the following modification to the ``startup.sh`` script;

.. code-block:: text

  ...

  <start_component_script> ${RUN_ARG} &

  ...

To make the ``startup.sh`` file available in the container, add the following to the bottom of the ``Dockerfile``;


.. code-block:: text

  COPY startup.sh /home/saluser/.startup.sh
  USER root
  RUN chown saluser:saluser /home/saluser/.startup.sh && \
      chmod a+x /home/saluser/.startup.sh
  USER saluser

Both the ``Dockerfile`` and ``startup.sh`` file should be added to a directory with the name of the component (in lower case), in the ``build`` directory.
If it is a multi-stage build, create a directory tree inside the ``build`` directory.
For example, the ``LOVE`` system contains six different builds.
The build scripts are located in;

.. code-block:: text

  build/love
  ├── commander
  │   ├── Dockerfile
  │   └── startup.sh
  ├── csc
  │   ├── Dockerfile
  │   └── startup.sh
  ├── frontend
  │   └── Dockerfile
  ├── manager
  │   └── Dockerfile
  ├── manager-static
  │   └── Dockerfile
  └── producer
    ├── Dockerfile
    └── startup.sh

Once the build scripts are created, the next step is to add the docker-compose build configuration.
The configuration is hosted in the ``cycle/docker-compose.yaml`` file.

For each component 2 identical images are built; one receives a ``cycle`` tag and the other a ``cycle.revision``.
In order to avoid duplication we create a template build configuration and add 2 components with different tagging schema.

At the top of the compose file, add the build configuration with the following format:

.. code-block:: text

  x-<component-name>: &base-<component-name>
    build:
      context: ../build/<component-name>
      labels:
        com.description: "<component-name> deployment image for cycle/revision ${CYCLE}${rev}."
      args:
        cycle: ${CYCLE}
        hub: ${hub}
        ....

Make sure to add all the required versions in the args sections above.

At the bottom of the compose file, add the following:

.. code-block:: text

  <component-name>:
    image: ${hub}/<component-name>:${CYCLE}${rev}
    <<: *base-<component-name>

  <component-name>_c:
    image: ${hub}/<component-name>:${CYCLE}
    <<: *base-<component-name>

Next add the components dependency versions to the cycle file in ``cycle/cycle.env``.

Finally, add the component to a build step in the ``Jenkinsfile.cycle`` file.
If the component is build on top of the ``deploy_env`` image, then add it to the list of base components in ``CONDA_PACKAGES`` and ``CONDA_PACKAGES_C`` and as an option in the parameter choice of ``base_components``.
They must have the same name as that added in the docker-compose file above.


.. _Developer_Guide_Building:

Building
========

In general users should rely on the `cycle build jenkins job`_ to execute builds.
Nevertheless, in some cases one may need to execute those locally for development, maintenance or customization purposes.

.. _cycle build jenkins job: https://tssw-ci.lsst.org/job/LSST_Telescope-and-Site/job/ts_cycle_build/

For instance, to build the ``deploy-conda-private`` locally one would do;

.. prompt:: bash

  git clone https://github.com/lsst-ts/ts_cycle_build.git
  cd ts_cycle_build/
  docker-compose -f cycle/docker-compose.yaml --env-file cycle/cycle.env build deploy-conda-private


.. _Developer_Guide_Dependencies:

Dependencies
============

* docker
* docker-compose

.. _Developer_Guide_Contributing:

Contributing
============

Code and documentation contributions utilize pull-requests on github.
Feature requests can be made by filing a Jira ticket with the `Build Cycle` label.
In all cases, reaching out to the :ref:`contacts for this CSC <CSC_developer>` is recommended.
