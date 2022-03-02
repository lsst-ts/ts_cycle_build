import argparse
from datetime import datetime, timezone
import pathlib


LOCATION_INFO = {
    "summit": {"endpoint": "cp", "bucket": "cp"},
    "tucson": {"endpoint": "tu", "bucket": "tuc"},
    "base": {"endpoint": "ls", "bucket": "ls"},
}


def main(opts):
    """Make S3 information based on site tag and file.

    Parameters
    ----------
    opts : `argparse.Namespace`
        Script options.
    """
    tags = LOCATION_INFO[opts.site_tag]
    s3_endpoint = f"https://s3.{tags['endpoint']}.lsst.org"
    s3_bucket = f"rubinobs-lfa-{tags['bucket']}"

    json_file = pathlib.Path(opts.json_file)
    now = datetime.now(timezone.utc)
    datetime_tag = now.strftime("%Y%m%d")
    target_json_file = (
        f"{json_file.stem}_{opts.site_tag}_{datetime_tag}{json_file.suffix}"
    )
    json_file = json_file.rename(target_json_file)

    key = [f"s3://{s3_bucket}", "LOVE", "view-backup", now.strftime("%Y/%W")]

    output = ["--endpoint-url", s3_endpoint, "s3", "cp", str(json_file), "/".join(key)]
    print(" ".join(output))


if __name__ == "__main__":
    description = "A script to create the command-line execution for the AWS cli."
    parser = argparse.ArgumentParser(description=description)

    parser.add_argument("site_tag", help="The site tag.")
    parser.add_argument(
        "json_file", help="The JSON file to rename with date information."
    )

    args = parser.parse_args()
    main(args)
