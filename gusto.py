import os
from os.path import normpath, exists, basename, isdir
import csv
import argparse

parser = argparse.ArgumentParser(description="Generate a CSV file for grading")
parser.add_argument(
    "PATH",
    help="""Path to the Snappy directory. It will be used for the name of the
    CSV file."""
)

parser.add_argument(
    "-f",
    "--force",
    action="store_true",
    help="Force overwrite existing CSV."
)

parser.add_argument(
    "-r",
    "--rubric",
    action='append',
    help="Specify rubric item values. Repeat if necessary."
)

args = parser.parse_args()

path = normpath(args.PATH)

if not exists(path):
    raise FileNotFoundError("Directory '{}' does not exist".format(path))
elif not isdir(path):
    raise NotADirectoryError("'{}' is not a directory".format(path))

path_csv = basename(path) + ".csv"

if (not args.force) and exists(path_csv):
    raise FileExistsError("Score table '{}' already exists".format(path_csv))

with open(path_csv, "w") as csvfile:
    fieldnames = [
        "name",
        "perm",
        "question",
        "score_max",
        "score_received",
        "comment"
    ]
    csv_writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

    csv_writer.writeheader()

    for _, dirs, _ in os.walk(path):
        dirs.sort()
        for dname in dirs:
            name, perm, *_ = dname.split("_")
            for idx, score in enumerate(args.rubric):
                csv_writer.writerow(
                    {
                    "name": name,
                    "perm": perm,
                    "question": idx,
                    "score_max": score
                    }
                )
