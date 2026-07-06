#!/usr/bin/env python3
"""
png-to-svg.py — Convert a PNG image to SVG format.

Two modes:
  --embed   (default) Embed the PNG as base64 inside an <image> SVG element.
            Works without extra dependencies. Output is technically SVG but
            still raster inside.
  --trace   Vectorize using vtracer (pip install vtracer).
            Produces true vector paths. Best for logos, icons, flat graphics.

Usage:
  python tools/png-to-svg.py input.png
  python tools/png-to-svg.py input.png -o output.svg
  python tools/png-to-svg.py input.png --trace
  python tools/png-to-svg.py *.png --trace          # batch
"""

import argparse
import base64
import sys
from pathlib import Path


def embed_png_in_svg(png_path: Path, svg_path: Path) -> None:
    """Wrap PNG as a base64-encoded <image> inside an SVG."""
    try:
        from PIL import Image
        with Image.open(png_path) as img:
            width, height = img.size
    except ImportError:
        # Fallback: read PNG header to get dimensions without Pillow
        width, height = _read_png_dimensions(png_path)

    png_data = png_path.read_bytes()
    b64 = base64.b64encode(png_data).decode("ascii")

    svg = (
        f'<?xml version="1.0" encoding="UTF-8"?>\n'
        f'<svg xmlns="http://www.w3.org/2000/svg" '
        f'xmlns:xlink="http://www.w3.org/1999/xlink" '
        f'width="{width}" height="{height}" '
        f'viewBox="0 0 {width} {height}">\n'
        f'  <image width="{width}" height="{height}" '
        f'xlink:href="data:image/png;base64,{b64}"/>\n'
        f'</svg>\n'
    )
    svg_path.write_text(svg, encoding="utf-8")


def _read_png_dimensions(png_path: Path) -> tuple[int, int]:
    """Read width/height from PNG IHDR chunk (no dependencies)."""
    import struct
    data = png_path.read_bytes()
    # PNG signature is 8 bytes, IHDR starts at byte 8
    # IHDR: 4 length + 4 type + 4 width + 4 height + ...
    if data[:8] != b'\x89PNG\r\n\x1a\n':
        raise ValueError(f"{png_path} is not a valid PNG file.")
    width, height = struct.unpack('>II', data[16:24])
    return width, height


def trace_png_to_svg(png_path: Path, svg_path: Path) -> None:
    """Vectorize PNG using vtracer (pip install vtracer)."""
    try:
        import vtracer
    except ImportError:
        print("ERROR: vtracer is not installed. Run: pip install vtracer")
        sys.exit(1)

    vtracer.convert_image_to_svg_py(
        str(png_path),
        str(svg_path),
        colormode="color",        # 'color' or 'binary'
        hierarchical="stacked",   # 'stacked' or 'cutout'
        mode="spline",            # 'spline', 'polygon', or 'none'
        filter_speckle=4,         # discard small patches (pixels)
        color_precision=6,        # number of significant bits for colors
        layer_difference=16,      # color difference between layers
        corner_threshold=60,      # angle threshold for corners (degrees)
        length_threshold=4.0,     # minimum spline segment length
        max_iterations=10,
        splice_threshold=45,
        path_precision=3,
    )


def convert(png_path: Path, svg_path: Path, mode: str) -> None:
    if not png_path.exists():
        print(f"ERROR: File not found: {png_path}")
        sys.exit(1)
    if png_path.suffix.lower() != ".png":
        print(f"WARNING: {png_path} does not have a .png extension, proceeding anyway.")

    if mode == "trace":
        trace_png_to_svg(png_path, svg_path)
    else:
        embed_png_in_svg(png_path, svg_path)

    print(f"[{mode}] {png_path} -> {svg_path}  ({svg_path.stat().st_size // 1024} KB)")


def main():
    parser = argparse.ArgumentParser(
        description="Convert PNG image(s) to SVG.",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=__doc__,
    )
    parser.add_argument("inputs", nargs="+", help="Input PNG file(s)")
    parser.add_argument("-o", "--output", help="Output SVG file (single input only)")
    parser.add_argument(
        "--trace",
        action="store_true",
        help="Vectorize with vtracer instead of embedding as base64",
    )
    parser.add_argument(
        "--embed",
        action="store_true",
        help="Embed PNG as base64 inside SVG (default)",
    )
    args = parser.parse_args()

    mode = "trace" if args.trace else "embed"

    inputs = [Path(p) for p in args.inputs]

    if args.output and len(inputs) > 1:
        print("ERROR: -o / --output can only be used with a single input file.")
        sys.exit(1)

    for png_path in inputs:
        if args.output:
            svg_path = Path(args.output)
        else:
            svg_path = png_path.with_suffix(".svg")
        convert(png_path, svg_path, mode)


if __name__ == "__main__":
    main()
