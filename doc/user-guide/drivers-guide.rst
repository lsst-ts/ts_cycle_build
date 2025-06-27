##########################
Cycle Build Driver's Guide
##########################

The Cycle Build contains all of the Dockerfiles for each CSC, deployment and development image.
It also contains the Jenkinsfiles for each build done during a cycle or revision.
A cycle is considered a major upgrade as schema incompatible interface changes are done here.
A revision is considered a minor upgrade as schema compatible interface changes can be done here.


**Rules**

* Only one commit to cycle.env per cycle or revision.
* Only make changes to the repo using a cycle or revision branch.
    * Exception is to make a branch that is then merged into afforementioned branch but the preference is to work directly on the branch
* No force pushes until a revision or cycle branch is closing, only use fixup commits please.

Building a new cycle
====================
Building a new cycle means building all new images for everything i.e. changes in the core libraries or interfaces.

1. Wait for the completion of the new XML release.
#. Create a new ticket with the title of "Cycle XX"
#. Create a new branch based off of main.
   It's fine if there's an open revision, you will deal with this later.
#. Create the slack thread.
#. Create a checklist with each stage to complete.
   Keep it updated as you make progress.
#. Use ts_vanward to get latest conda package releases
#. Start by modifying cycle.env to reset revision field to zero and increment the cycle field by 1.
#. Then update the package versions as needed.
#. Push the branch.
#. Navigate to the Jenkins job page and press the build button.
#. Once this first job is finished, refresh the page and there should be a "build with parameters" button.
#. Start going through the stages one by one.
   If there's a problem with any of them, continue with the others while debugging the failure.

    * Build Conda Package Builder Images
        * Usually works without an issue.
    * Build deploy-conda-private
        * Usually works without an issue.
    * Build deploy-lsstsqre-private
        * Usually works without an issue.
    * Build ts-cycle conda package
        * This one doesn't work but also isn't used.
          Probably should talk to Software Architect about removing it.
    * Build ALL base components
        * Usually fails the first time due to conda packages not always being built.
          Solution is to go to the conda packages tab and run missing tag builds.
    * Build ESS Controller Docker image
        * Usually works without an issue.
    * Build Vents Controller Docker image
        * Usually works without an issue.
    * Build AudioTrigger Controller docker image
        * Usually works without an issue
    * Build camera specific GenericCamera Docker images
        * Usually works without an issue.
    * Build M1M3 simulator
        * Check with M1M3 dev for any issues that come up.
    * Build VMS simulator
        * Check with M1M3 dev for any issues that come up.
    * Build PTG
        * Check with PTG dev for any issues that come up.
    * Build mtaos
        * Check with mtaos dev for any issues that come up.
    * Build oods
        * Usually works without an issue.
    * Build scriptqueue
        * Sometimes the base packages have an issue causing the build to fail.
    * Build SAL Sciplat (nublado) recommended image
        * Check with sqre team for any failures that come up.
    * Build RubinTV Rapid Analysis
        * Check with Sebastian.
    * Build development image
        * Usually builds without an issue.
    * Build Rubin ToO Producer image
        * New project.

#. (optional) If a revision from the previous cycle is merged to main then it is necessary to rebase onto it.
   Start by performing the interactive autosquash so that all the fixup commits to cycle.env are squashed.
   Then perform the rebase onto main and fix any conflicts in cycle.env.
   Force push the changes and then build any components that have new versions from the rebase.
#. Once all of the images are complete, inform the deployment lead.
#. Now the testing phase begins and others will make changes to the cycle.
#. Once deployment to the summit is complete, it is now time to close the cycle.
#. Perform the interactive autosquash rebase and then update the version history.
#. Force push the branch and open the PR.
#. Once approved, merge and delete the branch then announce the closure in the slack thread.

Building a new revision
=======================
* Check that a revision is not already open and being used.
* Open a OSW ticket and then create a branch off of the latest main.
* Increment the revision inside of cycle.env and optionally update any non core packages.
* Commit the change in cycle.env with no other changes present in any other files.
* Push the branch and open a slack thread in the ts-cycle-build channel with the following information

.. code::
    
    Cycle XX revision y(y) :yellow-circle: (OPENING) -> :thread:

* Inside of the thread then include the branch name and the commit for cycle.env to fixup.
* Then run the Jenkins job once to generate the build with parameters button.
* Now run any builds that you would like to update.
* Wait for sprint to end and close the revision.
* Announce the closure on the slack thread and perform the squashing of commmits.
* Finally update the version history and open the PR.
* Once approved merge and delete the branch then announce in the slack thread.


Incremental core package upgrade
================================
.. warning::
    This process is still undergoing formalization.
    We've done it once so far and it's likely that we'll learn more as we do it more often.

In order to update ts-xml incrementally, you will need to build scriptqueue and nublado along with whatever component has changed otherwise the communication will stop between those services and the component.

1. Wait for ts-xml release to be complete.
#. Open a new revision and update the ts-xml.
#. Create the commit and push the branch.
#. Build whatever components had their interfaces updated.
#. Build the scriptqueue and nublado images.
#. Inform deployment team that the images are ready to go.
#. Once they confirm things are working, close the revision.


Tracking the state of a cycle or revision
=========================================

In the slack channel ts-cycle-build, the ongoing state is tracked in the header of each post.

* OPEN
    * Make changes as you like.
* CLOSED
    * Merged to main and no more changes.
* OPENING
    * Making the initial change and creating the branch on GitHub.
* ClOSING
    * Squashing the fixup commits and creating the PR.
* PR OPEN
    * Pull Request is open and any changes should be made by opener as requested by reviewer.