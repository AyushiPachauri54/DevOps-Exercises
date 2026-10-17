"""Render a real captured log file (logs/*.txt) into a terminal-style PNG.
This does NOT run anything or invent text: it only draws the bytes of the log file."""
import sys, textwrap, glob, os
from PIL import Image, ImageDraw, ImageFont

FONT_CANDIDATES = [
    "/usr/share/fonts/truetype/dejavu/DejaVuSansMono.ttf",
    "/usr/share/fonts/truetype/liberation/LiberationMono-Regular.ttf",
    "/usr/share/texmf/fonts/opentype/public/lm/lmmono10-regular.otf",
]
font_path = next(p for p in FONT_CANDIDATES if os.path.exists(p))
FS, W = 15, 110
font = ImageFont.truetype(font_path, FS)

def render(log, out):
    raw = open(log, encoding="utf-8", errors="replace").read().replace("\t", "    ")
    # make "[exit code: N]" glued to previous output start on its own line (cosmetic only)
    raw = raw.replace("[exit code:", "\n[exit code:") if False else raw
    lines = []
    for l in raw.splitlines():
        lines += textwrap.wrap(l, W, drop_whitespace=False, replace_whitespace=False) or [""]
    lh = FS + 5
    h = lh * (len(lines) + 4) + 40
    w = int(font.getlength("M" * W)) + 40
    img = Image.new("RGB", (w, h), (30, 30, 30))
    d = ImageDraw.Draw(img)
    d.rectangle([0, 0, w, 28], fill=(60, 60, 60))
    d.text((12, 6), f"terminal capture (rendered from {os.path.basename(os.path.dirname(os.path.dirname(os.path.abspath(log))))}/logs/{os.path.basename(log)})", font=font, fill=(200, 200, 200))
    y = 40
    for l in lines:
        col = (220, 220, 220)
        if l.startswith("$"): col = (120, 220, 120)
        elif l.startswith("#") or l.startswith("=="): col = (130, 180, 255)
        elif "NOT" in l and ("INSTALLED" in l or "available" in l): col = (255, 190, 90)
        elif l.startswith("[exit code: 0]"): col = (140, 140, 140)
        elif l.startswith("[exit code:"): col = (255, 120, 120)
        d.text((20, y), l, font=font, fill=col); y += lh
    img.save(out)

for log in sorted(glob.glob("Exercise*/logs/*.txt")):
    ex = log.split("/")[0]
    out = f"{ex}/screenshots/terminal-capture-{os.path.splitext(os.path.basename(log))[0]}.png"
    render(log, out); print("wrote", out)
