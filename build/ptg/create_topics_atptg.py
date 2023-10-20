
import asyncio
from lsst.ts import salobj

async def main():
    async with salobj.Controller("ATPtg"):
        await asyncio.sleep(1)

if __name__ == "__main__":
    asyncio.run(main())
