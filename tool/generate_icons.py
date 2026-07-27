"""Generate brand icons for 소통사이트매니저."""

from __future__ import annotations

from pathlib import Path

from PIL import Image, ImageDraw

ROOT = Path(__file__).resolve().parents[1]
WEB = ROOT / "web"
ICONS = WEB / "icons"


def lerp(a: tuple[int, int, int], b: tuple[int, int, int], t: float) -> tuple[int, int, int]:
    return tuple(int(a[i] + (b[i] - a[i]) * t) for i in range(3))  # type: ignore[return-value]


def draw_icon(size: int, *, maskable: bool = False) -> Image.Image:
    img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)

    navy = (15, 39, 68)
    teal = (15, 118, 110)
    emerald = (45, 168, 140)
    warm = (232, 168, 92)
    cream = (248, 250, 252)

    # Soft radial-like background via concentric circles
    cx = cy = size // 2
    max_r = int(size * 0.52 if maskable else size * 0.48)
    for i in range(max_r, 0, -1):
        t = 1 - (i / max_r)
        color = lerp(navy, teal, t * 0.55)
        draw.ellipse((cx - i, cy - i, cx + i, cy + i), fill=(*color, 255))

    # Outer ring (knowledge hub)
    ring_w = max(2, size // 28)
    outer = int(size * (0.38 if maskable else 0.42))
    draw.ellipse(
        (cx - outer, cy - outer, cx + outer, cy + outer),
        outline=(*cream, 230),
        width=ring_w,
    )

    # Inner soft disk
    inner = int(size * 0.22)
    draw.ellipse(
        (cx - inner, cy - inner, cx + inner, cy + inner),
        fill=(*cream, 245),
    )

    # Compass needle (north = teal, south = warm)
    needle_h = int(size * 0.18)
    needle_w = max(2, size // 36)
    draw.polygon(
        [
            (cx, cy - needle_h),
            (cx + needle_w, cy),
            (cx, cy + needle_w),
            (cx - needle_w, cy),
        ],
        fill=(*emerald, 255),
    )
    draw.polygon(
        [
            (cx, cy + needle_h),
            (cx + needle_w, cy),
            (cx, cy - needle_w // 2),
            (cx - needle_w, cy),
        ],
        fill=(*warm, 255),
    )

    # Center hub
    hub = max(2, size // 22)
    draw.ellipse((cx - hub, cy - hub, cx + hub, cy + hub), fill=(*navy, 255))

    # Satellite nodes — connected knowledge domains
    node_r = max(3, size // 18)
    orbit = int(size * (0.30 if maskable else 0.34))
    positions = [
        (cx, cy - orbit),
        (cx + int(orbit * 0.87), cy - int(orbit * 0.5)),
        (cx + int(orbit * 0.87), cy + int(orbit * 0.5)),
        (cx, cy + orbit),
        (cx - int(orbit * 0.87), cy + int(orbit * 0.5)),
        (cx - int(orbit * 0.87), cy - int(orbit * 0.5)),
    ]
    for px, py in positions:
        draw.line((cx, cy, px, py), fill=(*cream, 160), width=max(1, size // 64))
        draw.ellipse(
            (px - node_r, py - node_r, px + node_r, py + node_r),
            fill=(*emerald, 255),
            outline=(*cream, 255),
            width=max(1, size // 96),
        )

    # Open book silhouette at bottom of inner disk for "knowledge"
    book_w = int(size * 0.16)
    book_h = int(size * 0.08)
    by = cy + int(size * 0.06)
    draw.polygon(
        [
            (cx - book_w, by),
            (cx, by - book_h // 3),
            (cx, by + book_h),
            (cx - book_w, by + book_h // 2),
        ],
        fill=(*navy, 200),
    )
    draw.polygon(
        [
            (cx + book_w, by),
            (cx, by - book_h // 3),
            (cx, by + book_h),
            (cx + book_w, by + book_h // 2),
        ],
        fill=(*teal, 220),
    )

    if not maskable:
        # Soft rounded square mask for non-maskable icons
        mask = Image.new("L", (size, size), 0)
        mask_draw = ImageDraw.Draw(mask)
        radius = int(size * 0.22)
        mask_draw.rounded_rectangle((0, 0, size - 1, size - 1), radius=radius, fill=255)
        output = Image.new("RGBA", (size, size), (0, 0, 0, 0))
        output.paste(img, mask=mask)
        return output

    return img


def main() -> None:
    ICONS.mkdir(parents=True, exist_ok=True)

    draw_icon(192).save(ICONS / "Icon-192.png")
    draw_icon(512).save(ICONS / "Icon-512.png")
    draw_icon(192, maskable=True).save(ICONS / "Icon-maskable-192.png")
    draw_icon(512, maskable=True).save(ICONS / "Icon-maskable-512.png")
    draw_icon(64).save(WEB / "favicon.png")
    draw_icon(180).save(WEB / "apple-touch-icon.png")
    print("Icons generated.")


if __name__ == "__main__":
    main()
