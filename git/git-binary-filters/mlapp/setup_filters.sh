#!/bin/bash


git config --local --replace-all filter.compressed.smudge "./zip.sh -- %f"
git config --local --replace-all filter.compressed.clean "./unzip.sh -- %f"

