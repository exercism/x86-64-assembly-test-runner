#!/usr/bin/env python3

import argparse
import json
from pathlib import Path
import re


rgx_testnames = re.compile(r"RUN_TEST\(([^)]+)\);")
last_test_name = {}


def get_last_test_name(filepath):
    if filepath not in last_test_name:
        last_test_name[filepath] = rgx_testnames.findall(
            Path(filepath).read_text())[-1]
    return last_test_name[filepath]


def build_task_map(test_file_path):
    """Parse // TASK: N comments from a test .c file.

    Returns a dict mapping test function names to task_id integers.
    Returns an empty dict if no TASK annotations are found (practice exercises).
    """
    task_map = {}
    current_task = None
    task_re = re.compile(r"^//\s*TASK:\s*(\d+)")
    func_re = re.compile(r"^void\s+(test_\w+)\s*\(")
    for line in Path(test_file_path).read_text().splitlines():
        m = task_re.match(line)
        if m:
            current_task = int(m.group(1))
            continue
        m = func_re.match(line)
        if m and current_task is not None:
            task_map[m.group(1)] = current_task
    return task_map


def truncate(text, maxlength=500):
    if len(text) > maxlength:
        text = f"{text[:maxlength]}\nOutput was truncated. Please limit to {maxlength} chars."
    return text


def process_results(filepath, task_map=None):
    task_map = task_map or {}
    output = {"version": 3, "status": "pass", "message": None, "tests": []}
    pattern = r"(?m)^((?P<file>.*_test\.c):\d+:(?P<name>\w+):(?P<status>PASS|FAIL)(?:: (?P<message>.*))?)$"
    text = filepath.read_text()
    for match in re.finditer(pattern, text):
        full_line, source_file, name, status, message = match.groups()
        case = {"name": name, "status": status.lower()}
        if name in task_map:
            case["task_id"] = task_map[name]
        if status == "FAIL":
            output["status"] = "fail"
        if message:
            case["message"] = message
        output_text, _, text = text.partition(f"{full_line}\n")
        if output_text:
            case["output"] = truncate(output_text)
        output["tests"].append(case)
        if name == get_last_test_name(source_file):
            break
    else:
        output["status"] = "error"
        output["message"] = text
    return output


def write_output_file(filename, output):
    with filename.open("w") as f:
        json.dump(output, f, indent=2)
        f.write("\n")


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("results_file", type=Path)
    parser.add_argument("solution_dir", type=Path)
    args = parser.parse_args()
    test_files = list(args.solution_dir.glob("*_test.c"))
    task_map = build_task_map(test_files[0]) if test_files else {}
    output = process_results(args.results_file, task_map)
    output_file = args.results_file.with_suffix(".json")
    write_output_file(output_file, output)


if __name__ == "__main__":
    main()
