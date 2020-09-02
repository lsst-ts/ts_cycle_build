"""Sphinx configuration file for TSSW package"""

from documenteer.sphinxconfig.stackconf import build_package_configs


_g = globals()
_g.update(build_package_configs(
    project_name='ts_cycle_build',
    version=""
))

intersphinx_mapping["ts_xml"] = ("https://ts-xml.lsst.io", None)
