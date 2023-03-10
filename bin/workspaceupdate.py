#!/usr/bin/env python3

import argparse
import os
import subprocess
import sys
from datetime import datetime

__version__ = "0.0.2"

HOME = os.getenv('HOME', os.getenv('USERPROFILE'))


def define_arguments():
    """
    Define allowed arguments.
    Refer to https://docs.python.org/3/library/argparse.html for documentation
    """
    parser = argparse.ArgumentParser("Update workspace repositories")
    parser.add_argument(
        "-v", "--version", action="version", version="%(prog)s " + __version__
    )
    parser.add_argument(
        "-s",
        "--source",
        type=str,
        metavar='/home/user/path/to/folder',
        help="Full path to repositories folder",
    )
    parser.add_argument(
        "-w",
        "--workspace",
        action='store_true',
        help="Update workspace repositories",
    )
    return parser


def parse_args(parser: argparse.ArgumentParser):
    """Process command line arguments"""
    args = parser.parse_args()

    if len(sys.argv) <= 1:
        sys.exit(f'No arguments given, run workspaceupdate -h')

    if args.workspace:
        return os.path.join(HOME, 'workspace')

    if args.source is not None and not os.path.exists(args.source):
        sys.exit(f"File not found: {args.source}")
    elif args.source:
        return args.source


def print_result(command: str, result: subprocess.CompletedProcess):
    """Print command results in a readable form"""

    print(f"\n[COMMAND] {command}\n")

    if result.returncode != 0:
        print(F"[ERROR]: Step {command} not successful with code {result.returncode}")

    print(f"[STDOUT] {result.stdout}")

    if result.stderr != "" and result.stderr != "Already on 'master'" and result.stderr != "Already on 'main'":
        print(f"[STDERR] {result.stderr}")

    print("\n")


def update_repos(workspace_dir: str):
    """Validates directory is a git repository,
    changes to said directory
    stashes any present changes, including untracked files,
    checks out master or main
    pull all changes from origin"""
    if workspace_dir is not None and not os.path.exists(workspace_dir):
        sys.exit(f"ERROR: Directory not found: {workspace_dir}")

    for dirpath, dirnames, filenames in os.walk(workspace_dir):
        # Validates directory is a git repository
        if ".git" in dirnames:
            repo = os.path.abspath(dirpath)
            # Change to given directory
            os.chdir(repo)

            date = datetime.now()
            print(f"\n#############################################################\n")
            print(f"[UPDATING REPOSITORY] {repo}")

            # stashes all changes including untracked files with a date message
            stash = subprocess.run(
                ["git", "stash", "push", "--include-untracked", "--message", str(date)],
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True,
                check=True
            )
            print_result(f"git stash push --include-untracked {str(date)}", stash)

            # Checks if default branch is master or main
            default = subprocess.run(
                ["git", "ls-remote", "--exit-code", "--heads", "origin", "main"],
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True,
            )
            if default.returncode == 0:
                default_branch = "main"
            else:
                default_branch = "master"

            # Checkout master or main, any other will return an error and stop script
            checkout_default_branch = subprocess.run(
                ["git", "checkout", default_branch],
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True,
                check=True
            )
            print_result(f"git checkout {default_branch}", checkout_default_branch)

            # Pull any changes from origin
            pull = subprocess.run(
                ["git", "pull"],
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True,
                check=True
            )
            print_result("git pull", pull)


arguments = define_arguments()
workspace_directory = parse_args(arguments)
update_repos(workspace_directory)
