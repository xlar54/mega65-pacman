#!/usr/bin/env python3
"""Patch BASIC 65 tokens that VICE petcat 3.6.1 does not emit correctly.

This is a Python port of basic65-compiler/tools/fix-basic65-petcat-tokens.ps1.
Every replacement has the same byte length, so BASIC line links remain valid.
"""

from __future__ import annotations

import argparse
from pathlib import Path


def fix_file(path: Path) -> int:
    data = bytearray(path.read_bytes())
    if len(data) < 7:
        return 0

    changed = 0
    pos = 2  # Skip the two-byte PRG load address.

    while pos + 4 <= len(data):
        if data[pos : pos + 2] == b"\x00\x00":
            break

        line_start = pos + 4
        try:
            line_end = data.index(0, line_start)
        except ValueError as exc:
            raise ValueError(f"Malformed tokenized BASIC file: {path}") from exc

        in_string = False
        in_data = False
        i = line_start
        while i < line_end:
            byte = data[i]

            if byte == 0x22:
                in_string = not in_string
                i += 1
                continue
            if in_string:
                i += 1
                continue
            if byte == 0x8F:  # REM: the rest of the line is literal text.
                break
            if byte == 0x83:  # DATA is literal until a colon.
                in_data = True
                i += 1
                continue
            if in_data:
                if byte == 0x3A:
                    in_data = False
                i += 1
                continue

            replacement: tuple[bytes, bytes] | None = None

            # SETBIT/CLRBIT: petcat leaves the BIT half as text.
            if (
                i + 4 <= line_end
                and ((byte == 0x2D and i > line_start and data[i - 1] == 0xFE) or byte == 0x9C)
                and data[i + 1 : i + 4] == b"BIT"
            ):
                replacement = (data[i : i + 4], bytes((byte, 0x20, 0xFE, 0x4E)))
            # VSYNC, RPT$, HASBIT and STRBIN$ are left as literal text.
            elif i + 5 <= line_end and data[i : i + 5] == b"VSYNC":
                replacement = (b"VSYNC", b"   \xFE\x54")
            elif i + 4 <= line_end and data[i : i + 4] == b"RPT$":
                replacement = (b"RPT$", b"  \xCE\x14")
            elif i + 6 <= line_end and data[i : i + 6] == b"HASBIT":
                replacement = (b"HASBIT", b"    \xCE\x13")
            elif i + 7 <= line_end and data[i : i + 7] == b"STRBIN$":
                replacement = (b"STRBIN$", b"     \xCE\x12")
            # DECBIN is emitted as DEC ($D1) followed by literal BIN.
            elif i + 4 <= line_end and byte == 0xD1 and data[i + 1 : i + 4] == b"BIN":
                replacement = (data[i : i + 4], b"  \xCE\x11")
            # LOG2 is emitted as LOG ($BC) followed by literal "2".
            elif i + 3 <= line_end and data[i : i + 3] == b"\xBC2(":
                replacement = (b"\xBC2", b"\xCE\x16")
            # DOT is emitted as DO ($EB) followed by literal "T".
            elif i + 2 <= line_end and data[i : i + 2] == b"\xEBT":
                replacement = (b"\xEBT", b"\xFE\x4C")
            # WPOKE/WPEEK are emitted as literal W plus petcat's old token.
            elif i + 2 <= line_end and byte == ord("W") and data[i + 1] == 0x97:
                replacement = (data[i : i + 2], b"\xFE\x1D")
            elif i + 2 <= line_end and byte == ord("W") and data[i + 1] == 0xC2:
                replacement = (data[i : i + 2], b"\xCE\x10")

            if replacement is not None:
                old, new = replacement
                if len(old) != len(new):
                    raise AssertionError("Token replacement changed program length")
                data[i : i + len(old)] = new
                changed += 1
                i += len(old)
            else:
                i += 1

        pos = line_end + 1

    if changed:
        path.write_bytes(data)
        print(f"Fixed {changed} BASIC65 extended token(s) in {path}")
    return changed


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("paths", nargs="+", type=Path)
    args = parser.parse_args()
    for path in args.paths:
        fix_file(path)


if __name__ == "__main__":
    main()
