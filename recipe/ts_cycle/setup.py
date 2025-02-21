import pathlib
from setuptools import setup

cycle_env = pathlib.Path(__file__).resolve().parents[2] / "cycle" / "cycle.env"
env_vars = {}

# Parse the entire cycle.env file in case this is needed in the future.
with cycle_env.open() as c:
    lines = c.readlines()
    for line in lines:
        if "=" in line:
            items = line.split("=")
            env_vars[items[0]] = items[1].strip()

version = f"{int(env_vars['CYCLE'][1:])}.0.0"
ts_xml_version = f"{env_vars['ts_xml']}"
ts_salobj_version = env_vars["ts_salobj"]

setup(
    version=version,
    ts_xml_version=ts_xml_version,
    ts_salobj_version=ts_salobj_version,
)
