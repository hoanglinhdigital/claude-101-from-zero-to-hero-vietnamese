#!/usr/bin/env python3
"""
find-and-replace.py
-------------------
Recursively finds and replaces text in all .html files under a given folder.

Usage:
    python tools/find-and-replace.py <folder> "<text-to-find>" "<text-to-replace>"

Example:
    python tools/find-and-replace.py section/section_2 "old-class" "new-class"
"""

import sys
from pathlib import Path


def find_html_files(folder: Path) -> list[Path]:
    """Return all .html files recursively under `folder`."""
    return sorted(f for f in folder.rglob("*.html") if f.is_file())


def replace_in_file(file_path: Path, find_text: str, replace_text: str) -> int:
    """
    Replace all occurrences of `find_text` with `replace_text` in a single file.
    Returns the number of replacements made. Writes back only if changed.
    """
    original = file_path.read_text(encoding="utf-8")
    if find_text not in original:
        return 0

    modified = original.replace(find_text, replace_text)
    count = original.count(find_text)
    file_path.write_text(modified, encoding="utf-8")
    return count


def main() -> None:
    if len(sys.argv) != 4:
        print('Usage: python tools/find-and-replace.py <folder> "<text-to-find>" "<text-to-replace>"')
        print()
        print("Example:")
        print('  python tools/find-and-replace.py section/section_2 "old-class" "new-class"')
        sys.exit(1)

    folder = Path(sys.argv[1])
    find_text = sys.argv[2]
    replace_text = sys.argv[3]

    if not folder.exists() or not folder.is_dir():
        print(f"Error: folder not found or not a directory: {folder}")
        sys.exit(1)

    if not find_text:
        print("Error: <text-to-find> must not be empty.")
        sys.exit(1)

    html_files = find_html_files(folder)
    if not html_files:
        print(f"No .html files found under: {folder}")
        return

    print(f"Folder      : {folder}")
    print(f"Find        : {find_text}")
    print(f"Replace     : {replace_text}")
    print(f"Scanning    : {len(html_files)} .html file(s)")
    print()

    total_files = 0
    total_replacements = 0

    for f in html_files:
        count = replace_in_file(f, find_text, replace_text)
        if count > 0:
            relative = f.relative_to(folder)
            print(f"  [{count:3d} replacement(s)]  {relative}")
            total_files += 1
            total_replacements += count

    print()
    print(f"Modified {total_files} file(s), {total_replacements} total replacement(s).")
    print("Done.")


if __name__ == "__main__":
    main()
