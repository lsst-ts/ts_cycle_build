"""Sphinx configuration file for an LSST stack package.
This configuration only affects single-package Sphinx documentation builds.
"""

from documenteer.conf.pipelinespkg import *  # noqa

project = "ts_cycle_build"
html_theme_options["logotext"] = project  # noqa
html_title = project
html_short_title = project
doxylink = {}  # Avoid warning: Could not find tag file _doxygen/doxygen.tag
