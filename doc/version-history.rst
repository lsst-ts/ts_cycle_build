===============
Version History
===============

.. At the time of writing the Version history/release notes are not yet standardized amongst CSCs.
.. Until then, it is not expected that both a version history and a release_notes be maintained.
.. It is expected that each CSC link to whatever method of tracking is being used for that CSC until standardization occurs.
.. No new work should be required in order to complete this section.
.. Below is an example of a version history format.

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
