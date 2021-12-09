
.. Fill out data so contacts section below is auto-populated
.. add name and email between the *'s below e.g. *Marie Smith <msmith@lsst.org>*
.. |CSC_developer| replace::  *Tiago Ribeiro*
.. |CSC_product_owner| replace:: *Tiago Ribeiro*

.. _User_Guide:

#######################
Build Cycle User Guide
#######################

.. Update links and labels below
.. image:: https://img.shields.io/badge/GitHub-ts_cycle_build-green.svg
    :target: https://github.com/lsst-ts/ts_cycle_build
.. image:: https://img.shields.io/badge/Jenkins-ts_cycle_build-green.svg
    :target: https://tssw-ci.lsst.org/view/CSC_Docker/job/cycleBuild/
.. image:: https://img.shields.io/badge/Jira-ts_cycle_build.svg
    :target: https://jira.lsstcorp.org/issues/?jql=labels+%3D+ts_cycle_build

This page explain how users can build deployable artifacts for the majority of the Vera Rubin Observatory control software.
This package focuses on those components that are deployed as docker containers, either as simulators and/or to control real hardware.

The observatory control software build system makes use of the concept of cycle and revision.

  Cycle
    Tracks the versions of a group of :ref:`core packages <Core-packages>` that affect all components.

  Revision
    Tracks the versions of all the other packages in the system.

Anytime a version of a core package changes a new cycle must be created.
Every new cycle starts with revision 0.
If the version of an individual package or dependency library changed, outside of the core packages, a new revision is created.
The build is then tagged accordingly;

.. prompt:: bash

  c<cycle-number>.<revision>

The resulting docker images are tagged similarly.
For instance, the image for the ``MTMount`` component for cycle 14, revision 3, will receive the name:

.. prompt:: bash

  ts-dockerhub.lsst.org/mtmount:c0014.003

The first part of the name is the nexus docker registry where we store the deployable artifacts, the second is the name of the image followed by the tag.

In addition, for each cycle the latest revision is tagged with the cycle only, e.g.;

.. prompt:: bash

  ts-dockerhub.lsst.org/mtmount:c0014

This allows for easily switching back and forth between revisions of a single cycle.

All images are annotated with the version information about the installed packages so one can easily inspect the content by doing:

.. prompt:: bash

  docker image inspect -f {{.Config.Labels}} ts-dockerhub.lsst.org/mtmount:c<cycle-number>.<revision>

.. _Core-packages:

Core packages
=============

The following is a list of the core packages that are used to define a particular cycle.

  - ts_ddsconfig: Contains DDS Quality of Service (QoS) configuration and various sanctioned OpenSplice configuration options for running systems in shared memory, single process and unit testing.
  - ts_xml: Contains the definition of the interfaces of all components in the system.
  - ts_sal: Contains the core DDS communication middleware layer.
  - ts_idl: Contains ancillary files used by ts_salobj and other higher level applications.
  - ts_salobj: High-level Python library to develop CSCs and SAL Script.


.. _Building-a-New-Cycle-or-Revision:

Creating a New Cycle or Revision
================================

The following is the procedure used to create and build a new cycle or revision.

.. _Building-a-new-Cycle-or-Revision-Workflow:

Workflow
--------

In general, it is expected that new cycle builds shall be deployed in one of the integration test stands to be tested before rolling to production (e.g. summit).
Because the validation process can take some time and since summit environment is in constant need for updates (new revisions), a new cycle can only be considered officially released after the production rollout.

To deal with this process in a more comprehensive way, this repository uses a different workflow than the one adopted by `TSSW`_.

.. _TSSW: https://tssw-developer.lsst.io/#id4

  - For the cycle build we adopt ``master`` as the main branch, and also the branch that tracks what is running in the production environment.

  - To start a new cycle, users must create a new branch that, initially, tracks the ``master`` branch.
    The branch must be named ``cycle/####``.
    For instance, when starting cycle 21, users will create a branch ``cycle/0021`` that tracks ``master`` at the time.

  - This branch should not receive any direct commits.
    Instead, users should create "ticket branches", with the name of the ticket they are working on.
    Note that the repository is setup so all ``cycle/*`` branches are automatically protected against direct commits.

    For instance, if the ticket you created to track the work to build cycle 21 is ``DM-12345``, you will create a ``tickets/DM-12345`` branch, based on the ``cycle/0021`` branch, to work with.

    Once the work is completed, a PR must be issued to merge ``tickets/DM-12345`` to ``cycle/0021``.

    .. attention::

      Make sure you select the correct cycle branch when opening a PR.
      By default GitHub will assign the ``master`` branch as a target to all PRs.
      You must manually select the cycle branch in this occasion.

  - If new revisions to the current cycle (say cycle 20) are needed to support the production environment, those changes must be done on ticket branches and merged back to ``master``, as usual.

  - If new revisions to the new cycle are needed, before the new cycle is officially released, ticket branches out of the new cycle branch should be created (e.g. ``cycle/0021``) and PRs must be opened and merged **back to the cycle branch**.

  - Once the new cycle is deployed at the summit and certified, a PR should be opened to merge the cycle branch back to master.
    The procedure is as follows:
      - Create a new branch out of the new cycle branch (e.g. ``cycle/0021``) pre-pending ``release/`` to the name (e.g. ``release/cycle/0021``).
        Rebase the ``release`` branch to ``master`` and open a PR to merge the ``release`` branch to master.
        The ``cycle`` branch will remain unchanged for historical purposes.
    - Once the PR is merged, the master branch receives a tag with the cycle and revision number (``cycle.revision``, e.g. ``c0021.000``).

  - From this point on, new PRs will be made directly to ``master``, until a new cycle is created.

Managing the Build
------------------

The cycle build is executed in the `Telescope and Site Software Jenkins server`_.
Users are required to select the version of the packages that will compose the cycle/revision and then run the :ref:`build steps <Building-a-new-Cycle-or-Revision-Build-Steps>` in an appropriate order.

.. _Telescope and Site Software Jenkins server: https://tssw-ci.lsst.org

.. note::

  At this point, cycle and revision are still managed manually by users.
  We are investigating ways of automating the process so users don't have to worry about setting them up.

To work on a new cycle or revision, one would start by cloning/updating the cycle build repository.

If you do not have a local copy of the build cycle repository, clone it with:

.. prompt:: bash

  git clone https://github.com/lsst-ts/ts_cycle_build.git

You may need to use the ssh version if you have two factor authentication (which you probably should).
In this case, do:

.. prompt:: bash

  git clone git@github.com:lsst-ts/ts_cycle_build.git

To update a local copy do;

.. prompt:: bash

  cd ts_cycle_build/  # Update the path to match the location of the package in your environment
  git checkout master
  git pull

If you are creating a new cycle, start by creating the cycle build and pushing it to github.
Considering you are starting cycle 21, do;

.. prompt:: bash

  git checkout cycle/0021
  git push

Then, create a ticket branch to work on:

.. prompt:: bash

  git checkout tickets/DM-12345  # Update the ticket number to match the ticket you are working on


Update the cycle/revision and software versions as needed.

.. important::

  If any of the :ref:`core packages <Core-packages>` version is updated, the cycle number must be incremented, otherwise just increment the revision number and update the software versions.

Both cycle, revision and all remaining software versions are managed by an environment file located in:

.. prompt:: bash

  cycle/cycle.env

At the very top you will find the cycle and revision numbers.
Since you know what kind of deployment (new cycle or new revision) you are going to be building, it is advisable to start by updating this information first.
After that, proceed to updating the required versions for each package.

For the :ref:`core packages <Core-packages>`, the version will be set in agreement with all the other subsystems.
Furthermore, one may be interested in updating the DM stack version (``lsstsqre``) as well.
All the other packages can either be inspected in github for the latest version or confirmed with their main developer.
In some cases, this process can be a bit time consuming as one needs to verify which version should be deployed with several different sources.

Once ``cycle/cycle.env`` is updated, you should be ready to start a build.
For that, commit and push your changes.
Make sure to describe the changes you have made on the commit message and also update the version history.

Once the changes are pushed to GitHub the branch will appear in the `cycle build jenkins job`_.
Select the branch you are working on in the Branch tab and select ``Build with Parameters`` on the left-hand side, which will take you to the :ref:`fig-jenkins-build-with-parameters`.

.. _cycle build jenkins job: https://tssw-ci.lsst.org/view/CycleBuild/job/cycleBuild/

.. figure:: /_static/JenkinsBuildWithParameters.png
   :name: fig-jenkins-build-with-parameters
   :target: ../_images/SingleProcessFig.png
   :alt: Jenkins build with parameters page

   Jenkins build with parameters page.

.. _Building-a-new-Cycle-or-Revision-Build-Steps:

Build Steps
^^^^^^^^^^^

The build is divided into steps to start from building base images up to deployable component images.
These steps are designed to maximize reusability of docker layers, minimizing the number of layers in the image and reducing the time it takes to build the system.
The steps in the build are as follows:

  - deploy_conda: Build base image used by all conda-installable components.
  - deploy_lsstsqre: Build base image used by components that require the DM stack.
  - base_components: Build either ALL or an individual component from conda packages.
    This includes the following components:

    - adam-sensors
    - ataos
    - atdome
    - atdometrajectory
    - athexapod
    - atmcs_sim
    - atpneumatics_sim
    - atspectrograph
    - dimm
    - dmocps
    - dsm
    - ess
    - genericcamera
    - hvac
    - love-commander
    - love-csc
    - love-frontend
    - love-manager
    - love-manager-static
    - love-producer
    - m1m3_sim
    - mthexapod
    - mtdome
    - mtdometrajectory
    - mtm2_sim
    - mtmount
    - mtrotator
    - ospl-daemon
    - pmd
    - salkafka
    - scheduler
    - watcher
    - weatherstation

  - build_m1m3_sim: Build M1M3 simulator.
  - build_ptg: Build pointing component.
    Both AT and MT use the same code base and image.
  - build_mtaos: Build MTAOS.
  - build_scriptqueue: Build ScriptQueue.
    Both AT and MT use the same code base and image.
  - build_salplat: Build base nublado image.
    This adds the Telescope and Site base layer to a base DM image needed for nublado.
  - build_sciplat_lab_recommended: Builds nublado images.
    Adds the final layer on the nublado images, needed to make them compatible with nublado system.

It is important to follow the build steps order.
Also, we recommend running one step at a time in the Jenkins server, to make sure the image is pushed correctly, avoiding a potential push problem at the end.

The build should always start with the base images; ``deploy_conda`` and ``deploy_lsstsqre``.
Since ``deploy_conda`` is quicker to build it is, in general, preferable to start with that one.

.. note::

	The most common issue in building the base images is that the core conda packages are not built yet.
  Most notably, the ``ts-idl`` package.

  It is, in general, required to run the build manually by going to the `ts-idl conda package job`_ in Jenkins, selecting the version of ``ts-idl`` to build in the "Tags" tab and building it with the appropriate version of ``ts-xml`` and ``ts-sal``.
  Note that this build may also fail if the RPM artifacts are missing.
  In this case, contact the build team in the `ts-build slack channel`_.

.. _ts-idl conda package job: https://tssw-ci.lsst.org/view/Conda_Jobs/job/IDL_Conda_package/
.. _ts-build slack channel: https://lsstc.slack.com/archives/CM6NYMG3F

Once both base images are built the system is ready to build the remaining components.
Again, given the simplicity and overall time it takes to complete, it is advisable to build the ``base_components`` next.
This step will build the majority of the systems.
Specifically, those that use the ``deploy_conda`` and are built from conda packages.

.. note::

  One of the most common issues in building this step is when the selected version of the conda package for a component (or library) is not available.
  In this case, make sure to check the conda Jenkins build for the particular package.
  On some occasions developers release the code before all required dependencies are available (in most cases the idl package) and the release build fails.
  For most cases, rerunning the build in Jenkins (after making sure the dependencies are available) should be enough to fix the problem.
  If further issues are encountered with the build for that particular package you can either attempt to fix it yourself (most cases are simple pep8 or black formatting issues) or contact the developer in charge of the component and request a patch.

Once the ``base_components`` are built successfully the natural next phase is to build ``MTM1M3`` simulator and pointing component, ``build_mtm1m3_sim`` and ``build_ptg``, respectively.
These are both C++ components built using the ``deploy_conda`` base image.
In both cases, the SAL libraries are installed using the rpm packages from the nexus server and the components are compiled at build time.

.. note::

	Sometimes it will happen that the RPM package with the library is not available for these components.
  This happens mostly when we update the version of OpenSplice.
  If this is the case contact the build team in the `ts-build slack channel`_.

.. note::

  We do have plans to change how these components are built in the future.
  The idea is to either build them as conda packages or RPMs.
  Since the pointing component contains private software and M1M3 is ultimately deployed in an embedded system, it is more likely that RPMs will be used.

The next natural step is then to build the ``ScriptQueue`` container via the ``build_scriptqueue`` job.
This image uses the ``deploy_lsstsqre`` as a base image and uses ``eups`` to install and build the dependencies for the ``ScriptQueue``, which means the step will take some time to finish.

Next, proceed to build the ``MTAOS`` component, which is also built on top of  ``deploy_lsstsqre``, due to its dependency on the DM stack.

Finally, build the two nublado images, ``build_salplat`` first and then ``build_sciplat_lab_recommended``, since the latter depends on the former to build.

With this, all systems are ready to be deployed.

.. _The-Development-Environment:

The Development Environment
===========================

The docker development environment is used is (now) part of the cycle build.
This docker image is built on top of the DM stack image (``lsstsqre/centos``) and contains all (or most) of the software needed for developing software for Telescope and Site stack.
The image also ships with the basic Telescope and Site software needed to develop components and ``SAL Scripts`` for the ``ScriptQueue``.
New packages can be added to the development environment by request.
In some cases, adding new dependencies may require some discussion and agreement with team members and acceptance by the Software Architect.

There are mainly three different types of development environment images; ``master``, ``develop`` and release cycle/revision tags.
The first two tags, ``master`` and ``develop``, are updated daily with the ``lsstsqre/centos:w_latest`` base image and all the Telescope and Site software using ``master`` and ``develop`` branches, respectively.
This process helps guard the system against potential breakages introduced by changes in any of the packages that are part of the image.

The cycle and revision tag images are built from the versions specified in ``cycle/cycle.env``.
They represent a frozen set of the system where all packages are built from tags.
For more information see :ref:`Building-a-new-Cycle-or-Revision`.

To pull one of these images simply do;

.. prompt:: bash

  docker pull lsstts/develop-env:<tag>

Where tag can either be ``master``, ``develop`` or ``<cycle>.<rev>``.
You can check the latest cycle/revision `here <https://github.com/lsst-ts/ts_cycle_build/blob/develop/cycle/cycle.env>`__.

Once the image has been pulled you can verify the version of all the Telescope and Site software in the image by inspecting the image labels.
The command is;

.. prompt:: bash

  docker inspect -f '{{ range $k, $v := .Config.Labels -}} {{ $k }}={{ $v }} {{ end -}}' lsstts/develop-env:<tag>

For ``master`` and ``develop`` all packages will have labels ``master`` and ``develop``, respectively, whereas cycle/revision images will show the packages tags.

In addition to the Telescope and Site software, the development image also ships with a number of packages used for development, for instance, ``pytest``, ``pytest-asyncio``, ``pytest-black`` and many others.
There are mainly three categories of software provided with the image, ``yum``, ``conda`` and ``pypi`` packages.

The list of ``yum`` packages available in the image are:

  - dos2unix
  - emacs
  - epel-release
  - gdb
  - git
  - gnome-terminal
  - graphviz*
  - ifconfig
  - java-1.8.0-openjdk-devel
  - libgphoto2-devel
  - ltrac
  - mariadb
  - mariadb-devel
  - maven
  - nano
  - ncurses-libs
  - net-tools
  - ntp
  - strace
  - swig
  - tcpdump
  - tk
  - tk-devel
  - tzdata
  - unzip
  - wget
  - which
  - xorg-x11-fonts-misc
  - xterm

In addition, ``OpenSpliceDDS`` is also installed using ``yum`` from our nexus repo.
This library provides the DDS communication middleware, which is the core of all Telescope and Site software.
The public image (available in the ``lsstts`` docker hub channel), ships with the ``6.9.0`` community edition version of the library built for ``el6``, to be compatible with the conda environment of the base ``lsstsqre/centos`` image.

.. note::

  We have plans to provide a version of this container with the licensed edition of the ``OpenSpliceDDS`` library from our private docker registry (``ts-dockerhub.lsst.org``).

Furthermore, the ``conda`` packages available in the image are managed through the `ts-develop`_ conda metapackage.
The list of packages are:

  - aiokafka
  - astroquery
  - asynctest
  - black ==19.10b0
  - boto3
  - ephem
  - fontconfig
  - ginga
  - gitpython
  - ipdb
  - ipympl
  - jinja2
  - jsonschema
  - jupyter
  - kafkacat
  - lxml
  - moto
  - pre-commit
  - pycodestyle
  - pyqt
  - pytest
  - pytest-asyncio
  - pytest-black
  - pytest-cov
  - pytest-flake8
  - pytest-subtests
  - pytest-tornasync
  - pyyaml
  - setuptools
  - setuptools_scm
  - sqlalchemy
  - wget

.. _ts-develop: https://anaconda.org/lsstts/ts-develop

Some dependencies that are not available through conda are added with ``pypi``:

  - aiomisc
  - aiounittest
  - confluent_kafka
  - documenteer[pipelines]==0.5.8
  - kafkit[aiohttp]
  - ltd-conveyor
  - pyevents

Finally, the list of Telescope and Site software that are ``eups`` installed are:

  - ts_ATDome
  - ts_ATDomeTrajectory
  - ts_ATMCSSimulator
  - ts_config_atcalsys
  - ts_config_attcs
  - ts_config_eas
  - ts_config_latiss
  - ts_config_mtcalsys
  - ts_config_mttcs
  - ts_config_ocs
  - ts_externalscripts
  - ts_hexrotcomm
  - ts_idl
  - ts_observatory_control
  - ts_sal
  - ts_salobj
  - ts_scriptqueue
  - ts_simactuators
  - ts_standardscripts
  - ts_tcpip
  - ts_xml
