===============
Version History
===============

.. At the time of writing the Version history/release notes are not yet standardized amongst CSCs.
.. Until then, it is not expected that both a version history and a release_notes be maintained.
.. It is expected that each CSC link to whatever method of tracking is being used for that CSC until standardization occurs.
.. No new work should be required in order to complete this section.
.. Below is an example of a version history format.

Cycle 34
========

* Pin OpenSSL on develop-env and deploy-env.
* Swap c and non c steps to fix CI.
* Have docker compose build images 1 by 1.
* Use python cycle argument for building ESS controller.
* Change SALSciPlat build to use main branch instead of prod branch.

* Update versions of the following packages:

    * ts_xml
    * ts_sal
    
    * lsstsqre
    * stack
    
    * ts_atdome
    * ts_atdometrajectory
    * ts_atmcssimulator
    * ts_mtrotator
    * ts_mthexapod
    * ts_observatory_control
    * ts_standardscripts
    * ts_externalscripts
    * ts_scriptqueue
    * ts_m2
    * ts_m1m3support
    * ts_criopy
    * ts_mtaos
    * ts_wep
    * ts_phosim
    * ts_watcher
    * ts_mtdome
    * ts_config_mttcs
    * love_frontend
    * love_manager
    * ts_fbs_utils
    * ts_observing
    * rubin_sim
    * ts_pointing_common
    * headerservice
    * robotframework_efd
    * ts_integrationtests

Cycle 33 revision 5
===================

* Update version of the following packages

  * ts_atmonochromator
  * ts_watcher.
  * love_frontend
  * love_manager
  * ts_fiberspectrograph
  * lsst_sqre
  * lsst_stack
  * ts_electrometer
  * ts_gis

Cycle 33 revision 4
===================

* Add missing node version on develop.env and main.env.

* Update version of the following packages:

  * ts_atmonochromator.
  * ts_observatory_control.
  * ts_standardscripts.
  * ts_externalscripts.
  * ts_watcher.
  * ts_config_latiss.
  * love-frontend.

Cycle 33 revision 3
===================

* Add node as an argument to develop-env build.

* Update version of the following packages:

  * DM stack.
  * ts_mtmount.
  * ts_config_latiss.
  * ts_config_mttcs.
  * love-frontend.
  * love-manager.
  * node (new).
  * ts_fbs_utils.
  * ts_observing.

Cycle 33 revision 2
===================

* Update Scheduler setup script to point configuration to obs-env if obs-env exists.
* In ``Jenkinsfile.cycle``:
  * Allow users to set a no cache option.
  * Stop using docker agent and use docker compose (that is now available in the nodes).
  * Allow users to select which node to run the build.
  * Build one component at a time.

* Update version of the following packages:

 * ts_watcher
 * ts_ess_common
 * ts_ess_csc
 * ts_config_atcalsys
 * ts_config_ocs
 * love_frontend
 * love_manager
 * ts_fbs_utils

Cycle 33 revision 1
===================

* Fix ``rapid-analysis`` build.
  There was some changes in how ``eups`` sets up packages that caused the deployment to fail.

* Updated ``mtm1m3_sim`` build.
  Stop cloning ``spdlog`` and install it using ``dnf``.

* Update version of the following packages:

  * ts_sal (patch).
  * atmospec.
  * DM-stack.
  * love_frontend.
  * love_manager.
  * Spectractor.
  * summit_extras.
  * summit_utils.
  * ts_config_latiss.
  * ts_cRIOcpp.
  * ts_m1m3support.
  * ts_mtaircompressor.
  * ts_mtrotator.
  * ts_watcher.

Cycle 33
========

* Implement fix for mamba mambabuild issue.
* Add ts_audio_broadcaster to Jenkinsfile.cycle.
* Add love-frontend-k8s to ALL option in Jenkinsfile.cycle.
    
Updated core products

* ts_xml
* ts_idl
* ts_salobj

Updated products

* ts_develop
* ts_hexrotcomm
* ts_atmcssimulator
* ts_m2
* ts_mtmount
* ts_pointing_common
* ts_m1m3support
* ts_lasertracker
* ts_mtaos
* ts_wep
* ts_ofc
* ts_mtdome
* ts_dsm
* ts_ess_common
* ts_conda_build
* ts_genericcamera
* ts_hvac
* ts_gis
* robotframework_efd
* headerservice
* ts_audio_broadcaster
* ts_config_attcs
* ts_config_eas
* ts_config_mttcs
* ts_config_ocs
* love_producer
* love_manager
* rubin_sim
* schedview

Cycle 32 revision 6
===================

* conda_builder linux64: Add libraries to support QT development.
* Add audio_broadcaster to Jenkinsfile.cycle

Updated components

* ts_standardscripts
* ts_externalscripts
* ts_config_ocs
* ts_observatory_control
* ts_integrationtests
* robotframework_efd
* ts_audio_broadcaster

Cycle 32 revision 5
===================

* Replace docker compose with docker-compose for OODS builds.
* Install nodejs 18.
* Update download leap seconds file URL.
* Fix dockerfile for OODS.

Updated components

* ts_develop
* love_frontend
* love_producer
* love_manager
* love_commander
* stack
* lsstsqre

Cycle 32 revision 4
===================
* Add oods.
* Add headerservice.

Updated components

* ts_observatory_control
* ts_standardscripts
* ts_externalscripts
* ts_config_latiss
* ts_config_ocs
* love_frontend
* love_manager

Cycle 32 revision 2
===================

* Fix label typos for salobj and dev pipelines

* Update version of the following packages:

  * DM stack version.
  * ts_config_ocs.
  * ts_scheduler.
  * summit_utils.
  * summit_extras.
  * Spectractor.
  * atmospec

Cycle 32 revision 1
===================

* Disable concurrent builds & add node 2 to label for salobj and develop env jenkinsfiles

* Setup ts_xml so packages that require it can find it.

* Update version of the following packages:

  * ts_watcher.
  * love_manager.
  * love_frontend.
  * ts_dimm.
  * ts_tcpip.

Cycle 32
========

* Add love-frontend kubernetes dockerfile.
* Skip integration tests for MTAOS.
* Rename rubintv-broadcaster to rapid analysis.
* Pass in python version using env files for develop, main and cycle.
* Updated builds to use python 3.11.
* Remove WeatherStation from Jenkinsfile.
* Add stack version to lsstsqre deploy env.

* Update versions of the following components:

  * ts_xml
  * ts_sal
  * ts_salobj
  * ts_idl
  * ts_develop
  * ts_hexrotcomm
  * ts_atmcssimulator
  * ts_atpneumaticssimulator
  * ts_athexapod
  * ts_atwhitelightsource
  * ts_mtrotator
  * ts_mthexapod
  * ts_salkafka
  * ts_observatory_control
  * ts_scriptqueue
  * ts_m2
  * ts_m1m3support
  * ts_criopy
  * ts_mtaircompressor
  * ts_lasertracker
  * ts_mtaos
  * phosim_utils
  * ts_wep
  * ts_ofc
  * ts_phosim
  * ts_mtdome
  * ts_mtdometrajectory
  * ts_dsm
  * ts_ess_common
  * ts_ess_controller
  * ts_ess_csc
  * ts_pmd
  * ts_integrationtests
  * ts_hvac
  * ts_electrometer
  * ts_fiberspectrograph
  * ts_gis
  * robotframework_efd
  * ts_config_mttcs
  * vimba_conda_build
  * ts_dateloc

Cycle 31 revision 6
===================

* Add ts_attcpip to the develop-env Docker image.

* Update version of the following packages:

  * ts_standardscripts.
  * ts_externalscripts.

Cycle 31 revision 5
===================

* Bulk update builds to use mamba instead of conda to install packages.

* Update dimm build to use mamba instead of conda.

* Update ATAOS build.

  * Remove old unused Dockerfile and replace it with the Dockerfile.conda file.
  * Update cycle/docker-compose.yaml file to stop using the (now deleted) Dockerfile.conda file.
  * Update build to use mamba.

* Update version of the following packages:

  * ts_ess_common.
  * ts_ess_csc.
  * ts_scheduler.
  * ts_dimm.
  * ts_config_ocs.
  * love_producer.
  * love_frontend.
  * love_manager.

Cycle 31 revision 4
===================

* In main and develop env files update ts_dds.

* Update version of the following packages:

  * ts_dds (update to python 3.11).
  * ts_standandscripts.
  * ts_scheduler.
  * love_commander.
  * love_frontend.
  * love_manager.
  * ts_config_ocs.

Cycle 31 revision 3
===================

* Update version of the following packages:

  * gphoto2.
  * ts_config_ocs.
  * ts_externalscripts.
  * ts_observatory_control.
  * ts_observing_utilities.
  * ts_scheduler.
  * ts_standardscripts.
  * ts_watcher.

Cycle 31 revision 2
===================

* In ScriptQueue build, fix name of ts_cRIOpy package when declaring it via eups.

* In develop-env setup.sh, replace reference to ts_cRIOpy to ts_criopy.

* In develop-env Dockerfile, replace reference to ts_cRIOpy to ts_criopy.

* In ``sal-sciplat`` build, fix name of ``ts_cRIOpy`` package.

* Install unzip in the coda builder Dockerfiles.

* Update `conda-builder-private` build configuration to tag images with CYCLE.rev.

* Update version of the following packages:

  * ts_scheduler.
  * ts_config_ocs.
  * LOVE-frontend.
  * ts_observatory_control.
  * ts_standardscripts.
  * ts_criopy.
  * ts_wep.

Cycle 31 Revision 1
===================

* Add python 3.11 to conda config

* Move conda config to common folder

* Updated packages:

  * ts_criopy.
  * ts_ess_csc.
  * ts_observatory_control.
  * ts_standardscripts.
  * ts_externalscripts.
  * love_manager.
  * love_frontend.
  * love_commander.

Cycle 31
========

* Add ts-xml conda package to deployment environments.
* Replace WeatherStation with ESS in PTG image.
* In rubintv-broadcaster, install conda packages in one step.
* In develop-env, only run pytest on tests directory for cRIOpy.

Updated Core products
* ts_xml
* ts_sal
* ts_salobj
* ts_idl

* Update lsstsqre to w22

Updated Packages
* ts_hexrotcomm
* ts_simactuators
* ts_atdome
* ts_mtrotator
* ts_mthexapod
* ts_observatory_control
* ts_scriptqueue
* ts_mtmount
* ts_m1m3support
* ts_mtaircompressor
* ts_wep
* ts_mtdome
* ts_tcpip
* ts_utils
* ts_fiberspectrograph
* love_commander
* love_manager
* ts_pointing_component
* ts_hvac
* ts_pointing_common
* ts_dimm
* robotframework_efd
* ts_atdome
* ts_ess_controller
* ts_ess_common

Cycle 30 revision 8
===================

* Update version of the following packages:

  * ts_lasertracker.
  * ts_scheduler.
  * love_commander.
  * love_producer.
  * love_frontend.
  * love_manager.

Cycle 30 revision 7
===================

* Update version of the following packages:

  * DM stack version.
  * ts_observatory_control.
  * ts_standardscripts.
  * ts_externalscripts.
  * ts_config_ocs.
  * ts_wep.

* In ScriptQueue build, fix name of ts_cRIOpy package when declaring it via eups.

* In sal-sciplat build fix name of ts-criopy package when declaring with eups.

* Update rubintv-broadcaster build to use the image_tag argument instead of hard-coded weekly.

Cycle 30 revision 6
===================

* Update develop env build to setup ts_config_ocs when building ts_observatory_control.

* Update salobj development env build to declare packages when installing them with pip in editable mode.

* Update the following packages:

  * integrationtests.
  * robotframework_efd.
  * love_manager.
  * love_commander.
  * love_frontend.

Cycle 30 revision 5
===================

* Add "-e" to the "pip" command in the SalObjContainer Dockerfile.

* Update version of the following packages:

  * ts_conda_build.


Cycle 30 revision 4
===================

* Remove eups/scons requirement for SalObjContainer.
* rubintv-broadcaster: add redis-py

* Update version of the following packages:

  * ts_atdometrajectory.
  * ts_mtdometrajctory.
  * ts_config_attcs.
  * ts_config_mttcs.
  * ts_atspec.


Cycle 30 revision 3
===================

* Fix the conda_package_builder_aarch64 Dockerfile.

* Update version of the following packages:

  * ts_observatory_control.
  * ts_standardscripts.
  * ts_externalscripts.
  * ts_m2.
  * ts_scheduler.
  * ts_ess_common.
  * ts_ess_controller.
  * ts_ess_csc.
  * ts_ess_labjack.
  * ts_hvac.
  * ts_config_mttcs.
  * ts_config_ocs.
  * love_frontend.
  * ts_fbs_utils.
  * schedview.


Cycle 30 revision 2
===================

* Add ts-criopy as a dependency in the following builds:

  * develop-env
  * sal-sciplat
  * scriptqueue

* In ``cycle/docker-compose.yaml``, pass in version of ts-criopy to all necessary builds

* Update the version of the following packages:

  * ts_config_mttcs
  * ts_observatory_control
  * ts_standardscripts
  * ts_externalscripts
  * love_frontend
  * ts-criopy (new)

Cycle 30 revision 1
===================

* Update the version of the following packages:

  * dm stack.
  * love_frontend
  * love_producer
  * rubin_sim.
  * schedview.
  * ts_atspec.
  * ts_config_mttcs
  * ts_config_ocs.
  * ts_ess_csc.
  * ts_externalscripts.
  * ts_fbs_utils.
  * ts_hvac.
  * ts_observatory_control.
  * ts_pmd.
  * ts_scheduler.
  * ts_standardscripts.
  * ts_watcher.

Cycle 30
========

* Update version of the following core packages:

  * ts_xml
  * ts_idl
  * ts_salobj

* Update version of the following products:

  * ts_develop
  * ts_hexrotcomm
  * ts_simactuators
  * ts_atdome
  * ts_atmonochromator
  * ts_atwhitelight
  * ts_mtrotator
  * ts_mthexapod
  * ts_ataos
  * ts_m2
  * ts_mtmount
  * ts_m1m3support
  * ts_cRIOcpp
  * ts_lasertracker
  * ts_wep
  * ts_ofc
  * ts_phosim
  * ts_watcher
  * ts_scheduler
  * ts_mtdome
  * ts_mtdometracjectory
  * ts_weatherstation
  * ts_ess_controller
  * ts_ess_labjack
  * ts_conda_build
  * ts_genericcamera
  * ts_hvac
  * ts_electrometer
  * ts_fiberspectrograph
  * ts_config_attcs
  * ts_config_mttcs
  * ts_config_ocs
  * ts_authorize
  * love_commander
  * love_producer
  * love_frontend
  * love_manager
  * ts_integrationtests
  * robotframework__efd
  * ts_pointing_common
  * ts_mtaos
  * ts_gis
  * ts_mtaircompressor
  * ts_m2
  * ts_weatherforecast
  * ts_scheduler

Cycle 29 revision 12
====================

* Update version of the following packages:

  * ts_config_ocs.
  * ts_watcher.
  * ts_ess_csc.
  * Spectractor.
  * summit_utils.
  * summit_extras.
  * atmospec.
  * ts_observing_utilities.
  * ts_wep.

* Update ScriptQueue build to load shared observing environment.

Cycle 29 revision 11
====================

* Update version of the following packages:

* love_frontend
* love_manager
* robotframework_EFD
* ts_integrationtests
* ts_pmd

Cycle 29 revision 10
====================

* Make the call to 'lsstinstall' also work for a cycle build.

* Update version of the following packages:

* ts_ess_common.
* ts_ess_csc.
* ts_config_ocs

Cycle 29 revision 9
===================

* Make sure that 'lsstinstall' always picks up the latest weekly instead of latest build.

* Update version of the following packages:

* ts_authorize.
* ts_ess_common.
* ts_integrationtest.
* love_frontend.
* love_manager.
* robotframework_EFD.

Cycle 29 revision 8
===================

* Fix a permissions issue on the arm64 conda package builder docker container.

* Rename ts_ATMCSSimulator to ts_atmcssimulator.

* Rename ts_ATPneumaticsSimulator to ts_atpneumaticssimulator.

* Update version of the following packages:

  * ts_fbs_utils.
  * ts_config_ocs.
  * DM stack.
  * ts_integrationtests.
  * ts_gis.
  * robotframework_efd.
  * rubintv.
  * love_frontend.
  * ts_fbs_utils.
  * ts_utils.
  * ts_config_mttcs.
  * ts_config_atcalsys.
  * ts_mtmount.
  * ts_atwhitelight.
  * ts_atmcssimulator.
  * ts_atpneumaticssimulator.

Cycle 29 revision 7
===================

* Update pointing model for the main telescope.

* Update version of the following packages:

  * ts_config_ocs.
  * ts_weatherforecast.
  * ts_authorize.
  * ts_ess_labjack.
  * ts_ess_csc (downgraded).
  * ts_config_ocs.
  * ts_pointing_common.
  * robotframework_EFD.
  * ts_integrationtests.

Cycle 29 revision 6
===================

* Update version of the following packages:

  * LOVE-frontend.
  * ts_ess_common.
  * ts_ess_csc.
  * ts_config_ocs.
  * ts_gis.
  * ts_weatherforecast.
  * ts_pointing_common.

* Update main telescope pointing model.

Cycle 29 revision 5
===================

* In ``build/scriptqueue``:

  * Install libglvnd-glx.
  * Makes some improvements in preparation for the shared environment.

    Changes include:

    * Stop running unit tests on packages that are not really necessary.
    * Reorder build steps such that it builds ancillary libraries first, then observatory control packages and script packages.
    * Install scriptqueue from conda instead of using clone/checkout.
      This package is static anyway, so there is no reason to use the repo with eups.

* In ``cycle/docker-compose.yaml``, pass in version of robotframework-efd package to integration test build.

* Updates for the integrationtests package:

  * Installing PyYAML and setting ``PYTHONPATH`` EnvVar the Dockerfile.

  * Set the RUN_ARG EnvVar in the Dockerfile to have no default value.

  * Added the robotframework_EFD repo to the cycle_build infrastructure.

  * Updated the RUN_ARG value in startup.sh to hardcode the robot command and make the EnvVar just be the unique switches and flags to the robot command.

  * Added to startup.sh a reporting exit code of the control process and then terminating script gracefully.

  * Moved the robot_efd version ARG in ``build/integrationtests/Dockerfile``.

* Add build scripts for GIS.

* Update version of the following packages:

  * DM stack.
  * ts-develop.
  * ts-observatory-control.
  * ts-externalscripts.
  * ts-standardscripts.
  * ts-scriptqueue.
  * ts-pointing-common.
  * ts-conda-build.
  * ts-gis (new).
  * robotframework-efd (new).
  * ts-config-ocs.
  * love-commander.
  * love-frontend.
  * love-manager.

Cycle 29 revision 4
===================

* Update cycle/docker-compose.yaml scheduler build configuration to pass in version of ts_observing.
* Pin version of numpy for conda_package_builder to 1.21 as used by DM.
* Update version of the following packages:

  * ts_ataos.
  * ts_config_latiss.
  * ts_config_ocs.
  * ts_genericcamera.
  * ts_observatory_control.
  * ts_observing.
  * ts_scheduler.

Cycle 29 revision 3
===================

* Ptg: update pointing model for the main telescope.
* In ``scheduler``, update build script to add new dependency; ts-observing.
* Update version of the following packages:

  * DM stack.
  * ts_scheduler.
  * ts_config_ocs.
  * ts_observing (new).
  * ts_observatory_control.
  * ts_externalscripts.
  * love_frontend.
  * rubin_sim.
  * schedview.

Cycle 29 revision 2
===================

* Remove rev from conda_package_builder private image tag for amd64 so all images are named the same.
* Fix permission issue on '/home/saluser/.setup.sh' file.
* Update version of the following packages:

  * ts_weatherforecast.
  * LOVE-commander.
  * LOVE-frontend.


Cycle 29 revision 1
===================

* In sal-sciplat build, source ospl environment when installing/setting up packages.
* In ScriptQueue build, setup ts_config_ocs when builing ts_standardscripts.
* In ``jenkins/Jenkinsfile.base``, set ``COMPOSE_HTTP_TIMEOUT=240`` in the docker run arguments.
* Update version of the following packages:

  * ts_pointing_common.
  * ts_config_ocs.
  * ts_pointing_common.
  * lsstsqre weekly.
  * ts_standardscripts.
  * ts_externalscripts.
  * ts_atspec.
  * ts_ess_controller.
  * dds_community_build_el7.
  * ts_ess_common
  * ts_ess_controller
  * ts_ess_csc.
  * ts_weatherforecast.
  * ts_electrometer.
  * ts_scheduler.
  * ts_fbs_utils.
  * rubin_sim.


Cycle 29
========

* Rename ts_mtalignment to ts_lasertracker.
* Remove ts_adamSensors.
* Remove pyside2, qasync, pytest_qt and pytest_xvfb because they moved to ts-develop.
* Add GenericCamera build step.
* Add develop_env to list of build steps.
* Update conda build config in preparation to adding Python 3.11 eventually.
* Update weatherforecast deployment container to include ts_config_ocs.
* Update the version of
    * ts_xml.
    * ts_idl.
    * ts_salobj.

    and also of many packages among which

    * ts_hexrotcomm.
    * ts_authorize.
    * ts_m2.
    * ts_mtmount.
    * ts_hvac.
    * ts_config_mttcs.
    * ts_wep.
    * ts_mtdome.
    * ts_ess_common.
    * ts_ess_csc.
    * ts_standardscripts.
    * ts_externalscripts.
    * ts_mtrotator.
    * ts_atwhitelight.
    * ts_genericcamera.
    * ts_integrationtests.
    * ts_atspec.
    * ts_weatherforecast.
    * love_commander.
    * love_frontend.
    * love_manager.
    * ts_config_ocs.
    * ts_config_mttcs.

Cycle 28 revision 7
===================

* Update version of the following packages:

  * ts_standardscripts.
  * ts_externalscripts.
  * ts_scheduler.
  * ts_config_ocs.
  * ts_astrosky_model.
  * ts_fbs_utils.
  * rubin_sim.
  * schedview.

* In Jenkinsfile.cycle rename rubintv-broadcaster-pub -> rubintv-broadcaster-usdf

* In ``scheduler`` build script, merge all mamba install commands in a single one.

Cycle 28 revision 6
===================

* Remove installing jupyterlab via mamba because it is part of ts-develop now.
* Update version of the following packages:

  * ts_authorize.
  * ts_genericcamera.
  * love-commander.
  * love-manager.

Cycle 28 revision 5
===================

* Remove pip packages from the base-sqre Dockerfile since they were moved to ts-develop.
* In rubintv-broadcaster, install rubin-env-rsp.
* In cycle/docker-compose.yaml, update schedview build configuration to pass version of bokeh.
* In schedview, update build script to pin version of bokeh.
* In scheduler, use mamba to install packages.
* Update version of the following packages:

  * ts_observatory_control.
  * ts_standardscripts.
  * ts_externalscripts.
  * ts_config_atcalsys.
  * ts_config_latiss.
  * ts_config_ocs.
  * ts_fbs_utils.
  * ts_develop.
  * rubin_sim.
  * bokeh (new).
  * ts_electrometer.
  * ts_authorize.

Cycle 28 revision 4
===================

* In ``cycle/docker-compose.yaml``, replace ``rubintv-broadcaster-pub`` builds with ``rubintv-broadcaster-usdf``, specifying UID/GID.
* In rubintv-broadcaster, refactor build script to move repositories to /repos.
* In ``rubintv-broadcaster``, add new dependency ``eo_pipe``.
* Update the version of the following packages:

  * ts_weatherforecast.
  * ts_hvac.

Cycle 28 revision 3
===================

* In ``Jenkinsfile.cycle``:
  * Add stage to build conda package builder for x86.
  * Add public build for rubintv images.
* In conda builder: Install new library libglvnd-glx, required by qt.
* In rubintv-broadcaster:
  * Stop installing ciso8601, ffmpeg and imagemagick.
  * Add a new ``DEPLOY_BRANCH`` environment variable that allows us to specify a branch to checkout before starting the process.
  * In the setup script, try to checkout the ``DEPLOY_BRANCH`` and if it doesn't exist just update the current branch in the package plan.
* Update ``cycle/docker-compose.yaml`` to add configuration for public rubintv images.
* Update the version of the following components.

  * ts_hvac.
  * ts_weatherforecast.
  * ts_ess_csc.
  * ts_mtaircompressor.
  * LOVE-frontend.
  * LOVE-manager.

Cycle 28 revision 2
===================

* Update pointing component build with new pointing model and add configuration for the pointing origin.
* Update version of the following packages:

  * ts_pointing_common.
  * ts_scheduler.

Cycle 28 revision 1
===================

* Update AT pointing model.
* In cycle/docker-compose.yaml, pass ts_utils to electrometer build.
* Electrometer: Add ts_utils to install command.
* Add configuration for ATMonochromator to Jenkinsfile.cycle and cycle/docker-compose.yaml
* Add ATMonochromator build scripts.
* Update version of the following packages:

  * dm-stack.
  * ts_pointing_common.
  * ts_scheduler.
  * ts_electrometer.
  * love_commander.
  * love_producer.
  * love_frontend.
  * love_manager.
  * (New) ts_atmonochromator.
  * ts_utils.
  * ts_config_ocs.

Cycle 28 revision 0
===================

* Add ts_weatherforecast Dockerfile and everything else.
* Update the version of:

  * ts_xml.
  * ts_sal.
  * ts_hexrotcomm.
  * ts_mtrotator.
  * ts_phosim.
  * ts_pmd.
  * ts_hvac.
  * ts_config_mttcs.
  * ts_mtmount.
  * ts_mtdome.
  * love_commander.
  * love_frontend.
  * love_manager.
  * ts_ess_common.
  * ts_ess_controller.
  * ts_ess_csc.
  * ts_authorize.
  * ts_config_ocs.
  * (New) ts_weatherforecast.

Cycle 27 revision 4
===================

* Update version of the following packages:

  * ts_wep.
  * ts_standardscripts.
  * ts_externalscripts.
  * ts_scheduler.
  * ts_config_ocs.
  * ts_hvac.
  * dm-stack.
  * ts_mtdome.

* In ``build/ptg``:

  * Update MT pointing model.
  * Update MTPtg configuration to limit azimuth to +/- 260.


Cycle 27 revision 3
===================

Update version of the following packages:

* ts_scheduler.
* ts_mtdome.

Cycle 27 revision 2
===================

* Install astrometry.net in rubintv broadcaster images.
* Update mtptg configuration.
* Update version of the following package:

  * ts_pointing_common.
  * LOVE-frontend.
  * LOVE-manager
  * ts_hvac.
  * ts_scheduler.
  * ts_config_ocs.
  * ts_fbs_utils.
  * rubin_sim.

Cycle 27 revision 1
===================

* Update the version of the following packages:

  * lsstsqre.
  * ts_genericcamera.
  * ts_config_ocs.

Cycle 27
========

* Switch scriptqueue build to mamba.
* In `Jenkinsfile.cycle` add step to build the development image.
* Fix kafka partial producer config for M1M3.
* Update mtaircompressor Dockerfile for new build instructions.
* Update mtaircompressor docker-compose to pass config repo version.
* Update version of

    * ts_ddsconfig
    * ts_xml
    * ts_idl
    * ts_salobj

  and other packages including

    * ts_atdome
    * ts_atdometrajectory
    * ts_ATPneumaticsSimulator
    * ts_atspec
    * ts_atwhitelight
    * ts_authorize
    * ts_mtrotator
    * ts_mthexapod
    * ts_observatory_control
    * ts_externalscripts
    * ts_scriptqueue
    * ts_ataos
    * ts_m2
    * ts_mtaircompressor
    * ts_mtalignment
    * ts_phosim
    * ts_watcher
    * ts_mtdome
    * ts_mtdometrajectory
    * ts_dimm
    * ts_ess_common
    * ts_ess_csc
    * ts_conda_build
    * ts_tcpip
    * ts_integrationtests
    * ts_config_atcalsys
    * ts_config_ocs

Cycle 26 revision 14
====================

* In ``build/sal-sciplat/Dockerfile``, fix issue with ATDome/ATDomeTrajectory -> atdome/atdometrajectory renaming.
* Update version of the following packages:

  * ts_atdometrajectory.
  * lsstsqre.
  * ts_scheduler.
  * ts_config_ocs.
  * ts_standardscripts.
  * ts_externalscripts.
  * ts_ataos.


Cycle 26 revision 13
====================

* Update the version of the following packages:

    * ts_config_ocs.
    * ts_fbs_utils.
    * ts_ataos.
    * ts_observatory_control.
    * ts_atdome.


Cycle 26 revision 12
====================

* Add astrometry.net to the nublado images.
* Split genericcamera into separate images.
* Update the version of the following packages:

  * LOVE-commander
  * LOVE-frontend
  * LOVE-manager
  * ts_standardscripts.
  * DM stack version.
  * ts_genericcamera.
  * ts_mtmount.

Cycle 26 revision 11
====================

* Rename the following packages:

  * ts_ATDome -> ts_atdome.
  * ts_ATDomeTrajectory -> ts_atdometrajectory.

* Add ts_fiberspectrograph.
* Update AT pointing model.
* Add data directory to ts_genericcamera.
* Update version of the following packages:

  * watcher.
  * ts_config_ocs.
  * ts_genericcamera.
  * LOVE-frontend.

Cycle 26 revision 10
====================

* Update user guide to have separate sessions for building a revision or a new cycle.
* Update ``Jenkinsfile.cycle`` to build a cycle and cycle.rev version of deploy-lsstsqre image.
* In ``cycle/docker-compose.yaml``, include configuration to build ``deploy-lsstsqre-private`` revision and revision.cycle.
  This is required because the deploy-lsstsqre can change with the revision, as we can update the DM stack version.
* Update version of the following packages:

  * ts_ataos.
  * ts_config_latiss.
  * ts_config_attcs.
  * ts_config_ocs.
  * ts_externalscripts.
  * ts_standardscripts.
  * LOVE-frontend.
  * schedview.

Cycle 26 revision 9
===================

* In ``Jenkinsfile.cycle``, add build atwhitelight to conda build list.
* In ``cycle/docker-compose.yaml``, add configuration for atwhitelight build.
* Add ``build/atwhitelight``, with the build configuration files for ATWhiteLight.
* In `build/scriptqueue`, update build script and startup script to include ts_wep.
* In `cycle/docker-compose.yaml`, update rubintv arguments and pass ts_wep version to  the scriptqueue build.
* Split rubinTV package versions in their own "namespace".
* Update version of the following packages:

    * lsstsqre stack.
    * ts_observatory_control.
    * ts_standardscripts.
    * ts_externalscripts.
    * ts_ataos.
    * ts_wep.
    * summit_utils.
    * summit_extras.
    * ts_config_ocs.
    * rubintv_spectractor (new rubin-tv deployment only).
    * rubintv_atmospec (new rubin-tv deployment only).
    * rubintv_summit_utils (new rubin-tv deployment only).
    * rubintv_summit_extras (new rubin-tv deployment only).
    * LOVE-frontend.
    * LOVE-manager.
    * ts_dimm.
    * ts_config_ocs.
    * ts_atwhitelight (new).
    * ts_matalignment.

Cycle 26 revision 8
===================

* Make sure that the HVAC CSC doesn't run as root.
* In `Jenkinsfile.cycle`, add build steps for new schedview app.
* In `cycle/docker-compose.yaml`, add build configuration for new schedview app.
* Add build scripts for new schedview app.
  This is a bokeh app with a scheduler visualization tool.
* Fix failing step in deployment images.
* Updated the integrationtests Docker image to conform to cycle_build standards.
* Cycle 26 revision 8. Update version of the following packages:

    * ts_config_ocs.
    * ts_ess_common.
    * ts_ess_csc.
    * ts_ess_controller.
    * DM stack.
    * lsst_efd_client.
    * ts_standardscripts.
    * ts_externalscripts.
    * ts_scheduler.
    * schedview (new package).
    * rubin_sim.
    * ts_fbs_utils.
    * ts_ataos

Cycle 26 revision 7
===================

* Fix ScriptQueue build, renaming ATMCSSimulator -> atmcssimulator.
* Update version of the following packages:

  * love-frontend
  * ts-dimm

Cycle 26 revision 6
===================

* Add xorg-x11-server-Xvfb and pytest-xfvb to the base-lsstsqre images.
* In sal-sciplat build, stop trying to checkout branch after cloning.
  The package is already cloned with the tag so there's no need to checkout again.
* Add ps and which to the deploy-conda and deploy-lsstsqre Docker images.
* Fix permission issue when using the ping command in the deploy env containers.
* Update version of the following packages:

  * ts_mtalignment
  * ts_atmcs
  * ts_hvac
  * ts_scheduler
  * ts_config_mttcs
  * ts_external_scripts

Cycle 26 revision 5
===================

* Add PySide2, pytest-qt and QT to the base-sqre develop images.
* Update version of the following packages:

  * ts_genericcamera
  * ts_config_ocs

Cycle 26 revision 4
===================

* In the Scheduler build, add version of ``lsst_efd_client``.
* In docker-compose, pass in ``lsst_efd_client`` version to the scheduler build.
* In love-manager and love-manage-static builds, try to clone v<tag> if <tag> only fails.
  This allows us to add the tag number without the trailing "v" in the cycle.env file.
* Update version of the following packages:

  * love-frontend
  * love-manager
  * ts-scheduler
  * ts-observatory-control
  * lsst_efd_client (new)
  * rubin_sim

Cycle 26 revision 3
===================

* Improve the way python-gphoto is installed in ``develop-env/lsstsqre`` and ``genericcamera``.
* Add build for MTAlignment CSC deployment.
* Fix sal-sciplat build.
* Update version of the following packages:

  * lsstsqre/stack
  * ts_mtalignment (new)
  * ts_ess_common
  * ts_ess_controller
  * ts_ess_csc
  * ts_config_ocs

Cycle 26 revision 2
===================

* Update sal-sciplat build to use mamba to install some dependencies, and reorganize some sequence of commands.
* Update develop-env build to take into account renaming of ATMCS simulator.
* Update version of the following packages:

  * ts_mtmount
  * ts_config_mttcs

Cycle 26 revision 1
===================

* In develop-env build update name of the ATMCS simulator component: ts_ATMCSSimulator -> ts_atmcssimulator.
* In MTAOS:

  * Update build to take into account module name change (MTAOS -> mtaos).
  * Update startup script to take into account module name change (MTAOS -> mtaos).

* Change ts_salkafka version and script for authentication.
* Install labjack-ljm conda package.
* Updated the versions of the following packages:

  * LOVE-frontend
  * LOVE-manager
  * ts_config_ocs
  * ts_ess_common
  * ts_ess_controller
  * ts_ess_labjack
  * ts_hvac
  * ts_m1m3support
  * ts_mtaircompressor
  * ts_mtaos
  * ts_mtmount
  * ts_observatory_control

Cycle 26
========

* Removed the files for the bare-centos docker container since it is no longer used.
* Corrected the variable 'dds_community_build_el7' to 'dds_community_build'.
* Updated the build versions for OpenSpliceDDS private and community to those valid for AlmaLinux.
* Migrated to AlmaLinux.
* Update version of

    * ts_ddsconfig
    * ts_xml
    * ts_sal
    * ts_idl
    * ts_salobj
    * ts_wep

  and almost all other packages including

    * love-commander
    * love-producer
    * love-manager
    * ts_athexapod
    * ts_ataos
    * ts_ess_labjack
    * ts_config_atcalsys
    * ts_config_attcs
    * ts_config_latiss
    * ts_config_mttcs
    * ts_config_ocs
    * ts_astrosky_model
    * ts_dateloc
    * ts_salkafka
    * ts_config_ocs
    * ts_mtmount
    * ts_atspec
    * pointing component
    * ts_atspec package
    * ts_mtaircompressor
    * m2
    * mtmount
    * ts_observatory_model
    * rubin_sim
    * ts_integrationtests
    * ts_integrationtests
    * ts_observatory_control
    * love-producer
    * scheduler
    * ts_atspec
    * dm_OCPS
    * ts_externalscripts
    * ts_standscripts

* Replace 'ljm_version' with 'labjack_ljm'.
* Pin Python version to 3.10.
* Introduce distinct versions of OpenSpliceDDS for Centos 7 and AlmaLinux 8.
* Set `OSPL_RELEASE` environment variable on setup scripts.
* In `cycle/docker-compose.yaml` update rpm version on ptg build configuration to use el8.
* Update osplice_build in `opensplice-lsstsqre-community` and `opensplice-lsstsqre-licensed` in build configuration.
* Update script queue build to use ts-develop instead of ts-conda-build.
* Update MTAOS build to use ts-develop instead of ts-conda-build,
* Fix executable name for many packages.
* Fix DSM container for shutdown script.
* Update MTM1M3 sim build to el8.
* Update script queue build to use new AlmaLinux8 version.
* Add spdlog depenency for MTM1M3-sim.
* Push cycle.rev tag for ESS Controller docker image.
* Add Jenkinsfiles for conda_package_builder and conda_package_builder_aarch64.
* Improve the conda package builder docker file for labjack-ljm.
* Fix an issue with the latest version of git.
* Pin the version of confluent_kafka.

Cycle 25 revision 10
====================

* Update atspectrograph executable name.
* Update version of the following packages:

    * ts_config_latiss
    * ts_config_ocs
    * ts_fbs_utils
    * ts_atspec

Cycle 25 revision 9
===================

* Update Scheduler startup script to remove the `.py`.
* Update version of the following packages:

    * ts_config_ocs
    * ts_scheduler

Cycle 25 revision 8
===================

* Add new scheduler dependency to cycle build; ts_fbs_utils.
* Update build configuration to add new scheduler dependency.
* Update scheduler build to add new dependency.
* In love-frontend update to ``node:lts`` docker image.
* Update version of the following packages:

  * ts_config_latiss
  * ts_config_ocs
  * ts_externalscripts

Cycle 25 revision 7
===================

* Pin Python version for conda package builder Docker files to 3.10.
* Unpin setuptools version in conda package builder Docker files.
* Pin combined versions of python and numpy in conda_build_config.yaml for conda_package_builder Dockerfiles.
* Update version of the following packages:

  * ts_observatory_control.
  * love_frontend.

Cycle 25 revision 6
===================

* Added the ts-cycle stage to the user documentation.
* Added the ts-cycle conda package stage.
* Add ts-cycle conda recipe.
* In ptg build, update default pointing model.
* Update version of the following packages:

  * ts_config_ocs.
  * ts_mtrotator
  * love-frontend.
  * ts_athexapod.
  * ts_observatory_control.
  * ts-tcpip.
  * ts-ess-common.
  * ts-ess-csc.
  * ts_standardscripts.

Cycle 25 revision 5
===================

* Extract commands to install all LabJack support files into a script.
* Call LabJack script from linux64 conda_builder, lsstsqre develop-env and ess Dockerfiles.
* Pin the version of setuptools to 59.8.0.
* Add labjack conda package to ess Dockerfile.
* Update version of the following packages:

  * ts_mtaircompresssor
  * ts_config_ocs

Cycle 25 revision 4
===================

* Update version of the following packages:

  * dm-stack (lsstsqre)
  * ts_observatory_control
  * ts_standardscripts
  * ts_externalscripts
  * ts_mtmount
  * ts_config_ocs

Cycle 25 revision 3
===================

* Update version of the following packages:

  * ts_tcpip
  * love_commander
  * love_frontend
  * love_manager

* Switch conda_builder Dockerfile to MambaForge.
* Add support for Authorize CSC.

Cycle 25 revision 2
===================

* Update version of the following packages:

  * ts_config_ocs

* Added conda_build_config.yaml to the conda_builder Docker files for support for both Python 3.8 and 3.10.
* Fixed installation of miniconda in linux64 conda_builder Dockerfile.

Cycle 25 revision 1
===================

* Update version of the following packages:

  * ts_hexrotcomm
  * ts_mthexapod
  * ts_config_mttcs
  * love_frontend
  * love_manager
  * love_commander
  * ts_observatory_control
  * ts_standardscripts
  * ts_externalscripts
  * ts_scheduler
  * ts_m2
  * ts_config_ocs
* Remove the following packages:

  * obs_base
  * pipe_tasks
  * rapid_analysis
* Add the following packages:

  * summit_utils
  * summit_extras
  * rubintv_production
* Update rubintv_broadcaster build configuration:

  * Remove:

    * rapid_analysis
  * Add new dependencies:

    * summit_utils
    * summit_extra
    * rubintv_production
  * Add new conda packages:

    * imagemagick
    * ffmpeg
* Update scriptqueue build configuration:

  * Remove:

    * local obs_base
    * local pipe_tasks
    * rapid_analysis
  * Disable local Spectractor
  * Add new dependencies:

    * summit_utils
    * summit_extras

Cycle 25
========

* Fix build of nublado recommended images and remove legacy code that was tagging/pushing "nts" specific images.
  Tag recommended nublado image.
* Update LOVE-commander build to add version of ts_observatory_control.
* Updated the Miniconda version to 4.11.0.
* Add LOVE view-backup container.
* Removed adam-sensors from the components lists.
* Updated and modernized all aarch64 build files.
* Update MTAOS build to remove custom obs_lsst. This was needed before due to issues with the site version of obs_lsst, which were resolved already.
* Added RubinTV Broadcaster to the user guide.
* Replaced ts_GenericCamera everywhere with ts_genericcamera.
* Add _c entry for mtaircompressor and fix _c list ordering.
* Changed NTS to TTS in the documentation.
* Update pointing models for the Auxiliary Telescope.
* Update rubintv-broadcaster build to remove inline obs_lsst.
* Fixed the BaseDevImage build by pinning NodeJS to version 17.
* Update version of the following packages:

  * ts_xml
  * ts_salobj
  * ts_develop
  * ts_hexrotcomm
  * ts_simactuators
  * ts_ATDome
  * ts_ATDomeTrajectory
  * ts_ATMCSSimulator
  * ts_ATPneumaticsSimulator
  * ts_athexapod
  * ts_atspec
  * ts_mtrotator
  * ts_mthexapod
  * ts_salkafka
  * ts_observatory_control
  * ts_standardscripts
  * ts_externalscripts
  * ts_scriptqueue
  * ts_ataos
  * ts_m2
  * ts_mtmount
  * ts_m1m3support
  * ts_cRIOcpp
  * ts_mtaos
  * ts_wep
  * ts_ofc
  * ts_phosim
  * ts_watcher
  * ts_scheduler
  * ts_mtdome
  * ts_mtdometrajectory
  * ts_dsm
  * ts_weatherstation
  * ts_dimm
  * ts_ess_common
  * ts_ess_csc
  * ts_conda_build
  * ts_tcpip
  * ts_genericcamera
  * ts_hvac
  * ts_electrometer
  * ts_config_atcalsys
  * ts_config_attcs
  * ts_config_latiss
  * ts_config_mtcalsys
  * ts_config_mttcs
  * ts_config_ocs
  * love_commander
  * love_producer
  * love_frontend
  * love_manager

* Added mtaircompressor container

Cycle 24 revision 10
====================

* Update version of the following packages:

  * ts_mtrotator

Cycle 24 revision 9
===================

* Update version of the following packages:

  * ts_observatory_control
  * rubin_sim
  * ts_hexrotcomm
  * love-manager
  * love-frontend


Cycle 24 revision 8
===================

* Update version of the following packages:

  * lsstsqre
  * ts_observatory_control
  * ts_standardscripts
  * ts_externalscripts
  * spectractor
  * rapid_analysis
  * atmospec
  * obs_lsst
  * ts_scheduler
  * ts_config_ocs
  * ts_config_latiss
  * love_producer
  * love_frontend
  * love_manager
  * love_commander

* In rubinTV broadcaster, remove `scons` from spectractor build.

Cycle 24 revision 7
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

* Update version of the following packages:

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
