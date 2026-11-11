#!/usr/bin/env python3
"""Draw a red, click-through border around every monitor while the battery is low.

Shown when the battery is discharging at or below THRESHOLD percent.
Needs python3-gi and gir1.2-gtklayershell-0.1.
"""
import os

import cairo
import gi

gi.require_version("Gtk", "3.0")
gi.require_version("Gdk", "3.0")
gi.require_version("GtkLayerShell", "0.1")
from gi.repository import GLib, Gdk, Gtk, GtkLayerShell  # noqa: E402

BAT = "/sys/class/power_supply/BAT0"
THRESHOLD = int(os.environ.get("LOWBAT_THRESHOLD", "10"))
BORDER = 6  # px
RED = (0.984, 0.286, 0.204)  # gruvbox #fb4934
POLL_SECONDS = 10


def read(name):
    with open(f"{BAT}/{name}") as f:
        return f.read().strip()


def is_low():
    try:
        return read("status") == "Discharging" and int(read("capacity")) <= THRESHOLD
    except (OSError, ValueError):
        return False


def draw(widget, cr):
    width, height = widget.get_allocated_width(), widget.get_allocated_height()
    cr.set_operator(cairo.OPERATOR_SOURCE)
    cr.set_source_rgba(0, 0, 0, 0)
    cr.paint()
    cr.set_source_rgba(*RED, 1)
    cr.set_line_width(BORDER * 2)  # half is clipped by the window edge
    cr.rectangle(0, 0, width, height)
    cr.stroke()
    return False


def make_window(monitor):
    win = Gtk.Window()
    win.set_app_paintable(True)
    win.set_visual(win.get_screen().get_rgba_visual())
    GtkLayerShell.init_for_window(win)
    GtkLayerShell.set_monitor(win, monitor)
    GtkLayerShell.set_layer(win, GtkLayerShell.Layer.OVERLAY)
    GtkLayerShell.set_exclusive_zone(win, -1)  # ignore bars, cover the whole output
    for edge in (
        GtkLayerShell.Edge.TOP,
        GtkLayerShell.Edge.BOTTOM,
        GtkLayerShell.Edge.LEFT,
        GtkLayerShell.Edge.RIGHT,
    ):
        GtkLayerShell.set_anchor(win, edge, True)
    win.connect("draw", draw)
    # Empty input region so clicks pass straight through to the windows below
    win.realize()
    win.get_window().input_shape_combine_region(cairo.Region(), 0, 0)
    return win


class Overlay:
    def __init__(self):
        self.windows = []
        self.update()
        GLib.timeout_add_seconds(POLL_SECONDS, self.update)

    def update(self):
        if is_low() and not self.windows:
            display = Gdk.Display.get_default()
            for i in range(display.get_n_monitors()):
                win = make_window(display.get_monitor(i))
                win.show_all()
                self.windows.append(win)
        elif not is_low() and self.windows:
            for win in self.windows:
                win.destroy()
            self.windows = []
        return True


if __name__ == "__main__":
    Overlay()
    Gtk.main()
