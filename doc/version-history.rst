===============
Version History
===============

.. At the time of writing the Version history/release notes are not yet standardized amongst CSCs.
.. Until then, it is not expected that both a version history and a release_notes be maintained.
.. It is expected that each CSC link to whatever method of tracking is being used for that CSC until standardization occurs.
.. No new work should be required in order to complete this section.
.. Below is an example of a version history format.

Cycle 24 revision 6
===================

* Update version of the following package(s)

  * ts_mtaos
  * ts_adamSensors
  * ts_config_eas

Documentation update
====================

* Revised the user documentation and made several small but important changes.

Cycle 24 revision 6
===================

* Update version of the following package(s)

  * ts_electrometer
  * ts_config_ocs

Cycle 24 revision 5
===================

* Update version of the following packages:

  * ts_mtmount

Cycle 24 revision 4
===================

* Update version of the following packages:

  * ts_mtmount

Cycle 24 revision 3
===================

* Update version of the following packages:

  * lsstsqre
  * ts_scheduler
  * Spectractor
  * rapid_analysis
  * ts_config_ocs
  * love-producer
  * ts_hexrotcomm
  * ts_mthexapod
  * ts_mtrotator
  * ts_config_latiss
  * ts_config_ocs

* In sal-sciplat, expand alpha, beta and rc tags.
* Add `astroplan` to sal-sciplat.
* In `develop-env/Dockerfile`, remove superfluous `WORKDIR`.
* In `develop-env/lsstsqre/Dockerfile` remove double `RUN`.
* In scriptqueue build script, try to setup git lfs beyond error.

Cycle 24 revision 2
===================

* Update version of the following packages:

  * ts_config_ocs

Cycle 24 revision 1
===================

* Update version of the following packages:

  * lsstsqre
  * ts_mtaos
  * obs_lsst
  * love-producer
  * ts_scheduler
  * ts_standardscripts
  * rubin_sim
  * pointing component
  * Spectractor

* Update startup script for love-producer.
* Update elevation limit for auxtel in the pointing to 17 degrees.
* Update pointing component build to set `OSPL_RELEASE`.
* Fix rubintv build
* In MTAOS, disable use of local obs_lsst.


Cycle 24
========

* Fixed a typo in the ts_hvac Dockerfile.
* The conda package for ESS CSC was renamed from ts-ess to ts-ess-csc.
* Update version of the following packages:

  * ts_xml
  * ts_sal
  * ts_idl
  * ts_salobj
  * ts_dds_community_conda_build
  * ts_dds_private_conda_build
  * ts_hexrotcomm
  * ts_simactuators
  * ts_mtrotator
  * ts_mthexapod
  * ts_salkafka
  * ts_mtmount
  * ts_m1m3support
  * ts_phosim
  * ts_scheduler
  * ts_mtdome
  * ts_weatherstation
  * ts_ess_common
  * ts_ess_csc
  * ts_tcpip
  * ts_utils
  * Spectractor
  * love_commander
  * love_frontend
  * love_manager
  * rubin_sim

Cycle 23 revision 10
====================

* Remove call to make_salpy_libs in salobj Dockerfile since that command was removed.
* Cycle 23 revision 10. Update version of the following packages in develop.env and main.env.

  * dds_community_build

Cycle 23 revision 9
===================

* Update sciplat-lab build to use the latest version of the lab build scripts.
* Update MTAOS build to use mamba to install conda packages and to stop ignoring wep failures.
* Update lsstsqre build to install mamba.
* On mtaos, use local obs_lsst.
* Cycle 23 revision 9. Update version of the following packages.

  * ts_mtaos
  * ts_mtmount
  * ts_wep


Cycle 23 revision 8
===================

* pin version of maven and openjdk in develop-env build.

Cycle 23 revision 7
===================

* In the develop-env, install maven (and java) using conda instead of yum to get a more recent version.


Cycle 23 revision 6
===================

* Update develop environment:

  * add labjack library.
  * add conda-build package.
  * add mamba (better and faster conda).

Cycle 23 revision 5
===================

* Update versions of the following packages:

  * ts_mthexapod
  * ts_config_ocs

Cycle 23 revision 4
===================

* On develop and main builds update build number of the dds python bindings.
* Update version of the following packages:

  * ts_hexrotcomm

Cycle 23 revision 3
===================

* Update versions of the following packages:

  * ts_mtaos
  * Spectractor
  * obs_base
  * pipe_tasks
  * ts_config_mttcs

* Update AT pointing model.

Cycle 23 revision 2
===================

* Update version of the following packages:

  * ts_mtaos
  * ts_config_mttcs

* Replace all references and use of master by main.

Cycle 23 revision 1
===================

* Update versions of:

  * ts_mtrotator
  * ts_mthexapod
  * ts_observatory_control
  * ts_m2
  * ts_mtmount
  * ts_ess_common
  * ts_ess_csc
  * obs_lsst
  * ts_config_mttcs
  * ts_config_ocs

* Update MTAOS build to use custom obs_lsst branch.

Cycle 23
========

* Update versions of:

  * xml
  * sal
  * idl
  * salobj
  * hexrotcomm
  * simactuators
  * ATPneumaticsSimulator
  * mtrotator
  * mthexapod
  * salkafka
  * observatory_control
  * scriptqueue
  * ataos
  * m2
  * mtmount
  * mtaos
  * wep
  * phosim
  * watcher
  * scheduler
  * mtdome
  * mtdometrajectory
  * ess_common
  * ess_csc
  * tcpip
  * hvac
  * utils
  * config_latiss
  * config_mttcs
  * config_ocs
  * electrometer

* Updated Jenkinsfile.cycle to work on newer versions of bash.
* Updated the recipe for building python-gphoto2.
* Updated the user guide to contain a more complete list of base components.

Cycle 22 revision 7
===================

* Update version of mtm2.
* Added a stage to Jenkinsfile.salobj to trigger the SAL Multi-Language integration tests.
  The tests build off the private version of the SalObj Docker image.

Cycle 22 revision 6
===================

* Fix entry in cycle.env for `MTDomeTrajectory`.
* Update develop-env/lsstsqre image to install "current" version of node.
* Update Jenkins build scripts to build the licensed version of develop-env.
* Cycle 22 revision 6. Update version of the following packages:
  * love-frontend.

Cycle 22 revision 5
===================

* Update version of the following packages:

  * ts_pointing_common
  * ts_scheduler
  * ts_integrationtests
  * rapid_analysis
  * obs_lsst (new)
  * ts_config_ocs
  * love_frontend
  * love_manager
  * rubin_sim

* Update rubintv-broadcaster to include local version of obs_lsst.
* Update pointing component configuration, and pointing model.
* Update Scheduler build to install lsst-efd-client.

Cycle 22 revision 4
===================

* Add integrationtests build scripts.

Cycle 22 revision 3
===================

* Update version of the following packages:

  * ts_externalscripts
  * ts_standardscripts

* Update test CSC container.
* Update develop environment setup script to setup PKG_CONFIG_PATH.

Cycle 22 revision 2
===================

* Update version of the following packages:

  * lsstsqre
  * ts_scheduler
  * rubin_sim
  * ts_config_ocs

* Change scheduler build to make it more reusable.
* Add environment variable to point scheduler to full sky brightness data.
* Updates for rubintv-broadcaster.

Cycle 22 revision 1
===================

*Update version of the following packages:

  * ts_hexrotcomm
  * ts_mtrotator
  * ts_mtmount
  * ts_ess_csc
  * ts_standardscripts
  * ts_externalscripts
  * ts_ataos
  * ts_mtaos
  * Spectractor
  * rapid_analysis

* Add git-lfs to conda_builder image.
* Fix lsstsqre gphoto build step.
* Fix rubintv-broadcaster Dockerfile:

  * Add ENTRYPOINT/CMD sections
  * Update Spectractor GitHub URL
  * Install missing packages

Cycle 22
========

* Update versions of:

  * ddsconfig
  * xml
  * sal
  * idl
  * salobj
  * ataos
  * DM stack version
  * develop
  * ATMCSSimulator
  * atspec
  * mtrotator
  * mthexapod
  * salkafka
  * scriptqueue
  * mtmount
  * m1m3support
  * mtaos
  * wep
  * ofc
  * phosim
  * scheduler
  * mtdome
  * dsm
  * dimm
  * conda_build
  * OPCS
  * tcpip
  * genericcamera
  * pmd
  * config_mttcs
  * config_ocs
  * config_ocps
  * love_frontend
  * love_manager
  * ts_observatory_control
  * rubin_sim

* Add ESS and HVAC CSC build scripts.
* Add utils version.
* In ScriptQueue build script, install git-lfs and checkout lfs files when building ts_observatory_control.
* In the develop-env build script, checkout lfs files when building ts_observatory_control.
* Add git-lfs to `develop-env/lsstsqre` image.
* Update version of
* Fix athexapod CSC startup script.
* In `Jenkinsfile.cycle`, update description and stage names for sal-sciplat and sal-sciplat-lab to be more explicit about their meaning.
* Update m1m3 startup script.
* Add slack notification on Jenkinsfile.lab.
* Fix Jenkisfile.lab to pass in docker credentials.
* Split building/pushing images in jenkinsfile.sciplat lab to deal with docker credentials.
* In `Jenkinsfile.sciplat` make nexus3 credentials available to build licensed version.
* Add RUN_ARG to watcher statup script.
* Update m1m3 simulator build script.
* Update version of m1m3 and add new dependency cRIOcpp.

Cycle 21 revision 7
===================

* Update versions of the following packages:

  * ts_atspec
  * ts_config_latiss

* In Jenkinsfile.cycle:

  * Improve description parameters on Jenkinsfile.cycle.
  * Implement safeguards against building base conda image and ALL CSCs when building revisions.

* Update Jenkisfiles.
* Update sal-sciplat build to use new `opensplice/lsstsqre` intermediate stage containers.
* Update compose file to build new `opensplice/lsstsqre` and sal-sciplat`.
* Add new build, `opensplice/lsstsqre-licensed`
* Add new build, `opensplice/lsstsqre-community`


Cycle 21 revision 6
===================

* Update versions of the following packages:

  * ts_config_attcs
  * ts_hexrotcomm
  * ts_mtrotator
  * DM stack version on cycle build.
  * ts_observatory_control
  * ts_mthexapod.

Cycle 21 revision 5
===================

* Update version of the following packages:

  * ts_ataos
  * ts_config_attcs
  * ts_dimm
  * love-frontend

* Add ts_utils to develop-env, deploy-env conda, deploy-env arch64 and sal-sciplat builds.
* In `Jenkinsfile.lab` Fix name of the branch (master -> prod) .

Cycle 21 revision 4
===================

* Update version of the following packages:

  * ts_config_attcs
  * ts_config_mttcs
  * ts_MTAOS
  * ts_mtmount (special version that communicates with the ccw controller in level 3)
  * ts_hexrotcomm (needed for mtmount to communicate with ccw controller in level 3)
  * ts_m2

* Add rubintv-broadcaster

Cycle 21 revision 3
===================

* Update version of the following packages:

  * ts_ofc
  * ts_externalscripts
  * ts_dimm
  * ts_config_ocs
  * love-frontend

* Remove deprecated scheduler build step. This is now part of the conda packages build.

Cycle 21 revision 2
===================

* Update Scheduler build scripts to use conda package.
* Add Scheduler to base components list instead of having separate build step.
* Remove lsst_sims step, this was replaced by the rubin-sim conda package.
* Add new dependencies (for scheduler):

  * ts_observatory_model
  * ts_astrosky_model
  * ts_dateloc
  * rubin_sim

* Update version of the following packages:

  * love_producer
  * ts_scheduler

* Update documentation.


Cycle 21 revision 1
===================

* Update versions of the following packages:

  * ts_mtmount
  * love_producer

Cycle 0021
==========

* Update versions of:

  * xml
  * ddsconfig
  * salobj
  * idl
  * DM stack version
  * atdome
  * mtrotator
  * salkafka
  * observatory_control
  * standardscripts
  * externalscripts
  * m2
  * mtaos
  * mtdometrajectory
  * tcpip
  * pmd
  * ts_config_mttcs
  * love_commander
  * love_producer
  * dmocps

* Fix launching SalSciplatLab in Jenkinsfile.cycle.
* In Jenkinsfile.sciplat:

  * Fix triggering SalSciplatLab.
  * Only trigger SalSciplat if building master branch.

* Add LOVE CSC build scripts.

Cycle 0020 revision 006
=======================

* Fix lab build for weekly.
* When building love front-end, support cloning tag when there is a "v" in front of the version.
* Update pointing limits.
* Update Jenkinfile.lab to tag images according to latest agreement with square folks.
* Update Jenkinsfile.cycle to take into account changes in Jenkinfile.lab.
* Update Jenkinsfile.sciplat to build daily at 4am and to trigger lab build.
* Add new pointing models for AT.
* Revision 006, update versions of the following packages:

  * ts_pointing_common
  * ts_observatory_control
  * ts_ataos
  * love-frontend

Cycle 0020 revision 005
=======================

* Add PMD

Cycle 0020 revision 004
=======================

* Add ts_tcpip to the develop env Dockerfile.
* Add tcpip to MTHexapod, MTRotator and MTMount.
* Minor fixes to scheduler build.
* Updated versions:

  * MTHexapod
  * MTRotator
  * MTMount
  * Scheduler
  * LOVE-commander

* Add GenericCamera.

Cycle 0020 revision 003
=======================

* Update versions of:

  * ts_mtaos
  * phosim_utils
  * ts_wep
  * ts_ofc
  * ts_phosim
  * ts_config_latiss
  * ts_observatory_control
  * ts_dsm

Cycle 0020 revision 002
=======================

* Add adam-sensors CSC build to the cycle.
* Update MTAOS version.
* Add love commander build.
* Add love-producer build.
* Add love-frontend build.
* Add love manager and love manager-static build.
* Update version of ts_develop to be less restringing.
* Fix sciplat build tagging.
* Fix Jenkinsfile.lab

Cycle 0020 revision 001
=======================

* Add OCPS and its config.
* Update versions of:

  * ts_hexrotcomm
  * ts_mthexapod
  * ts_mtaos
  * ts_ofc
  * ts_config_mttcs

* Made sure that LibGPhoto2, GPhoto2 and Python-GPhoto2 get installed in the base sqre development Docker images.

Cycle 0020
==========

* Rollback version of OpenSpliceDDS.
* Additional work to support building sal-sciplat-lab images in-house (from cycle build definition).
  The work is still in progress and mainly in experimental phase.

Cycle 0019 Revision 0002
========================

* Update hexrotcomm version.

Cycle 0019 Revision 0001
========================

* Update ts_observatory_control version.
* Update ts_atspec version.
* Update ts_mthexapod version.
* Add sal-sciplat build scripts.
  This image add the basic TSSW layer into a regular DM stack image.
  It should be usable by SQuaRE to build the nublado images.
* Update Jenkinsfile.cycle to add option to build sal-sciplat recommended.
* Add Jenkinsfile.sciplat to build daily and weekly versions of sal-sciplat.

Cycle 0019
==========

* Release of XML 9.0.0
* Updated the Dockerfiles of ptg and scriptqueue
* Removed unnecessary container aos_aoclc.
* Updated conda-builder for arch64
* Updated deploy-env for arch64

Cycle 0018 Revision 003
=======================

* Update MTAOS build script to ditch simulator tag, since the CSC is no longer a simulator.
* Update m1m3_sim build script and startup file to accept a `RUN_ARG` environment variable to control arguments.
* Update Ptg build to support building with Jenkins.
* Update Jenkinsfile.conda to be able to build ptg.
* Update OpenSplice setup configuration in develop and master builds to use OpenSplice build 16.

Cycle 0018 Revision 002
=======================

* Update ATPtg configuration to remove restricted rotator limits.
* Update version of ATSpectrograph.
* Initial support for the ESS.

Cycle 0018 Revision 001
=======================

* Update develop-env/lsstsqre to install kafkit and confluent_kafka with pypi.
* Update lsstsqre weekly to w_2021_12.
* Update ts_observatory_control to 0.7.4
* Update MTAOS to 0.5.3
* Update Scheduler to 1.5.2
* Update ATPtg configuration to limit nasmyth rotator angles to -40:-170 degrees due to issue with the mount.
* In MTAOS build ignore errors building wep.
  There are a couple of flake-8 errors when running scons.
  This needs to be fixed future releases.
* Add files to split script and scriptqueue producers into sub producers.
* On m1m3 producer configuration add sub producer for logMessage.
* Fix version history

Cycle 0018
==========

* Release of xml v8.0.0.
* Updated Python version to 3.8

Cycle 0017 Revision 004
=======================

* Update ataos version.
* Fix mtrotator build script.
* Update Jenkins build with parameters screen shot and minor tweaks to the documentation.
* Update pointing model file.

Cycle 0017 Revision 003
=======================

* Update m1m3 version.

Cycle 0017 Revision 002
=======================

* Updates done during the AT run SUMMIT-4829.

  * Fix script queue build.
  * Update version of ts_observatory_control
  * Update version of ts_ataos
  * Update version of obs_base
  * Update version of pipe_tasks
  * Update version of atmospec
  * Update version of ts_observing_utilities
  * Update version of ts_config_attcs

 * General fixes to develop-env build.

  * Install ltd-conveyor using pip.


Cycle 0017 Revision 001
=======================

* Update cycle build to support building one image at a time.
* Update version of weather station conda package.
* Update weather station build script to install new conda package.
* Update hexrotcomm version.
* Update mthexapod version.
* Changed M1M3 simulator version to v2.0.1.

Cycle 0017
==========

Release of xml v7.1.0.

Cycle 0016
==========

Release of xml v7.0.0.

Cycle 0015
==========

Release of salobj 6/sal 5 with xml 6.2.1.
Adds Jenkinsfile for development environment build, along with refactored build scripts.

Cycle 0014
==========

Official release of salobj 6/sal 5 with xml 6.1.0.

Cycle 0013
==========

Continuing tests with salobj 6/sal 5.

Cycle 0012
==========

Updating deployment to use new partitioning schema implemented in salobj 6/sal 5.
This is also an experimental feature in sal/salobj to try to improve the how data is organized in the DDS Global Data Storage.
This experiment is part of a task to obtain a stable DDS deployment.

Cycle 0011
==========

Updating deployment to use disposable QoS for telemetry topics.
This is an experimental feature on sal/salobj to see if we alleviate the system dictionary by making telemetry disposable.
This experiment is part of a task to obtain a stable DDS deployment.

Cycle 0010
==========

Updating deployment to use xml 6.1.0 and salojb 5.17.0.
Major updates to build and deploy containers with licensed version of OpenSplice and testing shared memory mode.
See tstn-023 for more details about shared memory mode and this cycle.


Cycle 0009
==========

First use of deployment cycle using xml 6.0.0, sal 4.1.4 and salobj 5.15.0.
