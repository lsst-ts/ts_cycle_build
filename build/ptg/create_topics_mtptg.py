
import asyncio
from lsst.ts import salobj

async def main():
    async with salobj.Controller("MTPtg"):
        await asyncio.sleep(1)

if __name__ == "__main__":
    asyncio.run(main())
