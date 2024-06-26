import argparse
import json
import operator
import os
import pathlib

JSON_OUTPUT = "initial_data.json"


def make_view_dict():
    """Skeleton for the JSON view information.

    Returns
    -------
    `dict`
        JSON view information skeleton.
    """
    return {
        "model": "ui_framework.view",
        "pk": -1,
        "fields": {
            "creation_timestamp": "",
            "update_timestamp": "",
            "name": "",
            "data": {},
            "thumbnail": "",
        },
    }


def make_timestamp(values):
    """Convert and fix SQL timestamps to JSON timestamps.

    Parameters
    ----------
    values : `list` of two `str`
        The date and time strings to be joined.

    Returns
    -------
    `str`
        The JSON timestamp.
    """
    temp = "T".join(values)
    return temp.replace("+00", "Z")


def main(opts):
    """Handle the conversion of SQL output to JSON.

    Parameters
    ----------
    opts : `argparse.Namespace`
        Script options.
    """
    views = []
    with opts.sql_file.open() as ifile:
        for line in ifile:
            parts = line.split("\t")
            try:
                fixture = int(parts[0])
                if opts.verbose > 2:
                    print("Parts:", parts)
                view_spec = make_view_dict()
                view_spec["pk"] = fixture
                fields = view_spec["fields"]
                fields["creation_timestamp"] = make_timestamp(parts[1].split())
                fields["update_timestamp"] = make_timestamp(parts[2].split())

                if opts.verbose > 2:
                    print("First fields:", fields)

                fields["name"] = parts[3]
                if opts.verbose > 2:
                    print(f"Name: {fields['name']}")
                fields["data"] = json.loads(parts[4])
                fields["thumbnail"] = parts[5]

                if opts.verbose > 1:
                    print("Spec:", view_spec)
                views.append(view_spec)
            except (IndexError, ValueError):
                pass

    views.sort(key=operator.itemgetter("pk"))
    print(f"Total number of views: {len(views)}")
    if opts.show_views:
        print(views)

    if opts.site_tag is not None:
        parts = JSON_OUTPUT.split(".")
        output_filename = parts[0] + "_" + opts.site_tag + "." + parts[1]
    else:
        output_filename = JSON_OUTPUT

    with open(output_filename, "w") as ofile:
        json.dump(views, ofile, indent=2)
        ofile.write(os.linesep)


if __name__ == "__main__":
    description = ["A script to take a SQL dump of the LOVE database view table and"]
    description.append("convert it to the JSON file used by the LOVE manager.")
    parser = argparse.ArgumentParser(description=" ".join(description))

    parser.add_argument("sql_file", type=pathlib.Path, help="The SQL file to convert.")

    parser.add_argument(
        "--site-tag", type=str, help="Site specific tag to add to the filename."
    )

    parser.add_argument(
        "-v", "--verbose", action="count", default=0, help="Increase script output."
    )

    parser.add_argument(
        "--show-views", action="store_true", help="Show constructed views."
    )

    args = parser.parse_args()
    main(args)
