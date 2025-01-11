import asyncio
from lsst.ts import salobj


async def main():
    async with salobj.Controller("MTM1M3TS"):
        await asyncio.sleep(1)


if __name__ == "__main__":
    asyncio.run(main())
