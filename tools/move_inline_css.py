#!/usr/bin/env python3
"""
move_inline_css.py
------------------
Moves all CSS rules inside <style>...</style> blocks from a given HTML file
into styles.css (located in the current working directory).

- If a selector already exists in styles.css, its properties are merged
  (new properties from the HTML file take precedence for conflicts).
- If a selector is new, it is appended to styles.css.
- The <style> block(s) are removed from the HTML file.

Usage:
    python move_inline_css.py <relative/path/to/file.html>

Run from the project root so that styles.css is found at ./styles.css.
"""

import re
import sys
from pathlib import Path


# ---------------------------------------------------------------------------
# CSS parsing helpers
# ---------------------------------------------------------------------------

def strip_comments(css: str) -> str:
    """Remove /* ... */ comments from CSS text."""
    return re.sub(r'/\*.*?\*/', '', css, flags=re.DOTALL)


def parse_properties(props_text: str) -> dict[str, str]:
    """Parse a CSS declaration block body into an ordered dict of {prop: value}."""
    props: dict[str, str] = {}
    for declaration in props_text.split(';'):
        declaration = declaration.strip()
        if ':' not in declaration:
            continue
        key, _, value = declaration.partition(':')
        key = key.strip()
        value = value.strip()
        if key:
            props[key] = value
    return props


def props_to_text(props: dict[str, str], indent: str = '    ') -> str:
    """Render a properties dict to declaration-block body text."""
    return ''.join(f'{indent}{k}: {v};\n' for k, v in props.items())


def parse_css_flat_rules(css: str) -> list[tuple[str, dict[str, str]]]:
    """
    Parse flat (non-nested) CSS into a list of (selector, props_dict) tuples.
    At-rules that open nested blocks (@media, @keyframes, etc.) are skipped.
    """
    css = strip_comments(css)
    rules: list[tuple[str, dict[str, str]]] = []

    # Match selector { body } — body must not contain nested { }
    for m in re.finditer(r'([^{@][^{]*?)\{([^{}]*)\}', css, re.DOTALL):
        selector = m.group(1).strip()
        body = m.group(2)
        if not selector:
            continue
        props = parse_properties(body)
        if props:
            rules.append((selector, props))

    return rules


# ---------------------------------------------------------------------------
# styles.css update helpers
# ---------------------------------------------------------------------------

def selector_regex(selector: str) -> re.Pattern:
    """
    Build a regex that matches an existing rule for `selector` in CSS text.
    Captures: (open_brace_with_selector)(body)(close_brace)
    """
    escaped = re.escape(selector)
    # Allow optional whitespace between selector and {
    return re.compile(
        rf'({escaped}\s*\{{)([^{{}}]*)(\}})',
        re.DOTALL,
    )


def merge_into_styles(styles_path: Path, new_rules: list[tuple[str, dict[str, str]]]) -> int:
    """
    Merge new_rules into styles_path in-place.
    Returns the number of selectors appended (new) vs updated (existing).
    """
    content = styles_path.read_text(encoding='utf-8')
    to_append: list[tuple[str, dict[str, str]]] = []
    updated = 0

    for selector, new_props in new_rules:
        pattern = selector_regex(selector)
        match = pattern.search(content)

        if match:
            # Merge: parse existing props, overlay new ones, rewrite block
            existing_props = parse_properties(match.group(2))
            merged = {**existing_props, **new_props}  # new_props win on conflict
            new_body = '\n' + props_to_text(merged)
            replacement = match.group(1) + new_body + match.group(3)
            content = content[: match.start()] + replacement + content[match.end() :]
            print(f'  [updated]  {selector}')
            updated += 1
        else:
            to_append.append((selector, new_props))

    if to_append:
        lines = ['\n\n/* ── Moved from inline <style> ── */']
        for selector, props in to_append:
            lines.append(f'\n{selector} {{\n{props_to_text(props)}}}')
        content += '\n'.join(lines) + '\n'

    styles_path.write_text(content, encoding='utf-8')

    for selector, _ in to_append:
        print(f'  [appended] {selector}')

    return updated, len(to_append)


# ---------------------------------------------------------------------------
# HTML processing helpers
# ---------------------------------------------------------------------------

def extract_style_blocks(html: str) -> list[str]:
    """Return the inner text of every <style>…</style> block."""
    return re.findall(r'<style[^>]*>(.*?)</style>', html, re.DOTALL | re.IGNORECASE)


def remove_style_blocks(html: str) -> str:
    """Remove every <style>…</style> block (and surrounding blank lines) from html."""
    # Replace block + optional surrounding whitespace with a single newline
    cleaned = re.sub(
        r'[ \t]*<style[^>]*>.*?</style>[ \t]*\n?',
        '',
        html,
        flags=re.DOTALL | re.IGNORECASE,
    )
    # Collapse triple+ blank lines that may remain
    cleaned = re.sub(r'\n{3,}', '\n\n', cleaned)
    return cleaned


# ---------------------------------------------------------------------------
# Entry point
# ---------------------------------------------------------------------------

def main() -> None:
    if len(sys.argv) < 2:
        print('Usage: python move_inline_css.py <relative/path/to/file.html>')
        sys.exit(1)

    html_path = Path(sys.argv[1])
    if not html_path.exists():
        print(f'Error: HTML file not found: {html_path}')
        sys.exit(1)

    styles_path = Path('styles.css')
    if not styles_path.exists():
        print('Error: styles.css not found in the current directory.')
        print('Run this script from the project root.')
        sys.exit(1)

    print(f'Input : {html_path}')
    print(f'Target: {styles_path.resolve()}')
    print()

    # 1. Read HTML and locate <style> blocks
    html_content = html_path.read_text(encoding='utf-8')
    style_blocks = extract_style_blocks(html_content)

    if not style_blocks:
        print('No <style> blocks found — nothing to do.')
        return

    # 2. Parse all CSS rules from every <style> block
    all_rules: list[tuple[str, dict[str, str]]] = []
    for block in style_blocks:
        all_rules.extend(parse_css_flat_rules(block))

    if not all_rules:
        print('Style blocks found but contained no parseable rules — nothing to do.')
        return

    print(f'Found {len(style_blocks)} <style> block(s) with {len(all_rules)} CSS rule(s).\n')

    # 3. Merge rules into styles.css
    updated, appended = merge_into_styles(styles_path, all_rules)

    print()
    print(f'styles.css: {updated} rule(s) updated, {appended} rule(s) appended.')

    # 4. Remove <style> blocks from HTML and save
    new_html = remove_style_blocks(html_content)
    html_path.write_text(new_html, encoding='utf-8')

    print(f'HTML file : <style> block(s) removed from {html_path}')
    print('\nDone.')


if __name__ == '__main__':
    main()
