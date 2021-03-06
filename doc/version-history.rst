===============
Version History
===============

.. At the time of writing the Version history/release notes are not yet standardized amongst CSCs.
.. Until then, it is not expected that both a version history and a release_notes be maintained.
.. It is expected that each CSC link to whatever method of tracking is being used for that CSC until standardization occurs.
.. No new work should be required in order to complete this section.
.. Below is an example of a version history format.

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
