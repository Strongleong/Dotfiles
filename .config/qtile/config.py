from libqtile import bar, layout, widget, hook, qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

import os
import socket
import subprocess

mod = "mod4"
alt = "mod1"
terminal = guess_terminal()
browser = "firefox"
gap_size = 15
editor = "neovide --multigrid"


def set_wallpaper(qtile=None):
    os.popen("feh --randomize --bg-fill /usr/share/backgrounds/*")


@hook.subscribe.startup_once
def autostart():
    set_wallpaper()
    script = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.run([script])


@lazy.function
def spawn_float_term(qtile, *argv):
    # `qtilerun` is basically a script with the command `qtile run-cmd $@ &`.
    # `terminal` is a path to an actual terminal.
    command = ['qtile', 'run-cmd', '--float', terminal, '--hold', '-e']
    for argument in argv:
        if isinstance(argument, list):
            command.extend(argument)
        else:
            command.append(argument)
    return subprocess.Popen(command)


keys = [
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod, alt], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, alt], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, alt], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, alt], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod, "control"], "space", lazy.window.toggle_floating(), desc="Toggle floating"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
    Key([mod], "Left", lazy.screen.prev_group(), desc="Move to next group"),
    Key([mod], "Right", lazy.screen.next_group(), desc="Move to prev group"),
    Key(
        [mod, "control"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        lazy.spawn("rofi -show drun"),
        desc="Show rofi with drun command",
    ),
    Key(
        [mod, "control"],
        "Return",
        lazy.layout.toggle_split(),
        lazy.spawn("rofi -show run"),
        desc="Show rofi with run command",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "Tab", lazy.next_layout(), desc="Next layout"),
    Key([mod, "shift"], "Tab", lazy.prev_layout(), desc="Next layout"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a prompt widget"),
    Key([mod], "q", lazy.spawn(browser), desc="Spawns browser"),
    Key([mod], "o", lazy.spawn(editor), desc="Spawns editor"),
    Key([mod, "shift"], "n", lazy.function(set_wallpaper), desc="Set random wallpaper"),
    Key([], "Print", lazy.spawn('flameshot gui'), desc="Spawns flameshow"),
    Key([], "XF86MonBrightnessUp", lazy.spawn('light -A 10'), desc="Decrease backlight"),
    Key([], "XF86MonBrightnessDown", lazy.spawn('light -U 10'), desc="Inccrease backlight"),
    Key(['control', 'shift'], "l", lazy.spawn("dm-tool lock"), desc="Lock screen"),
    Key([mod, 'control'], 'h', lazy.to_screen(0), desc="Move to screen 1"),
    Key([mod, 'control'], 'l', lazy.to_screen(1), desc="Move to screen 2"),
    Key([mod], 'b', lazy.hide_show_bar(), desc="Toggle bar"),
    Key(
        [mod],
        "space",
        lazy.widget["keyboardlayout"].next_keyboard(),
        desc="Next keyboard layout"
    )
]

groups = [Group(i) for i in "12345"]

for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
                desc="move focused window to group {}".format(i.name)),
        ]
    )

config = {
    "border_focus": "#ECEFF4",
    "border_normal": "#8FBCBB",
    "border_focus_stack": "#B48EAD",
    "border_normal_stack": "#5E81AC",
    "border_width": 1,
    "border_on_single": True,
    "margin": 20,
    "num_stacks": 2,
    "font": "RobotoMono Nerd Font"
}

layouts = [
    layout.Columns(**config),
    layout.Max(**config),
    layout.Stack(**config),
    layout.Bsp(**config),
    layout.Matrix(),
    layout.MonadTall(**config),
    layout.MonadWide(**config),
    layout.RatioTile(**config),
    layout.Tile(**config),
    layout.TreeTab(**config),
    layout.VerticalTile(**config),
    layout.Zoomy(**config),
]


def init_colors():
    return [["#2e3440", "#2e3440"],  # color 0  dark grayish blue
            ["#2e3440", "#2e3440"],  # color 1  dark grayish blue
            ["#3b4252", "#3b4252"],  # color 2  very dark grayish blue
            ["#434c5e", "#434c5e"],  # color 3  very dark grayish blue
            ["#4c566a", "#4c566a"],  # color 4  very dark grayish blue
            ["#d8dee9", "#d8dee9"],  # color 5  grayish blue
            ["#e5e9f0", "#e5e9f0"],  # color 6  light grayish blue
            ["#eceff4", "#eceff4"],  # color 7  light grayish blue
            ["#8fbcbb", "#8fbcbb"],  # color 8  grayish cyan
            ["#88c0d0", "#88c0d0"],  # color 9  desaturated cyan
            ["#81a1c1", "#81a1c1"],  # color 10 desaturated blue
            ["#5e81ac", "#5e81ac"],  # color 11 dark moderate blue
            ["#bf616a", "#bf616a"],  # color 12 slightly desaturated red
            ["#d08770", "#d08770"],  # color 13 desaturated red
            ["#ebcb8b", "#ebcb8b"],  # color 14 soft orange
            ["#a3be8c", "#a3be8c"],  # color 15 desaturated green
            ["#b48ead", "#b48ead"]]  # color 16 grayish magenta


colors = init_colors()

prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

widget_defaults = dict(
    font='RobotoMono Nerd Font',
    fontsize=12,
    padding=3,
    background=colors[1],
    foreground=colors[5]
)
extension_defaults = widget_defaults.copy()


def init_widgets_list(monitor):
    widget_list_left = [
        widget.Sep(
            background=colors[1],  # 2e3440
            foreground=colors[5],  # d8dee9
            linewidth=1,
            padding=10
        ),
        widget.Image(
            filename="~/.config/qtile/icons/qtilelogo.png",
            iconsize=8,
            background=colors[1],
            mouse_callbacks={'Button1': lambda: qtile.cmd_spawn('rofi -show drun')}
        ),
        widget.Sep(
            background=colors[1],
            foreground=colors[5],
            linewidth=1,
            padding=10
        ),
        widget.GroupBox(
            active=colors[6],
            borderwidth=2,
            disable_drag=True,
            font='RobotoMono Nerd Font',
            fontsize=14,
            hide_unused=False,
            highlight_method='line',
            inactive=colors[16],
            margin_x=0,
            margin_y=3,
            padding_x=5,
            padding_y=8,
            rounded=False,
            this_current_screen_border=colors[14],  # ebcb8b
            urgent_alert_method='line'
        ),
        widget.Sep(
            background=colors[1],
            foreground=colors[5],
            linewidth=1,
            padding=10
        ),
        widget.CurrentLayoutIcon(
            background=colors[1],
            custom_icon_paths=[os.path.expanduser("~/.config/qtile/icons")],
            foreground=colors[6],  # e5e9f0
            padding=0,
            scale=0.65
        ),
        widget.CurrentLayout(
            background=colors[1],
            font='RobotoMono Bold',
            foreground=colors[6]
        ),
        widget.Sep(
            background=colors[1],
            foreground=colors[5],
            linewidth=1,
            padding=10
        ),
        widget.Prompt(
            background=colors[1],
            font='RobotoMono',
            fontsize=12,
            foreground=colors[6]
        ),
        widget.WindowTabs(
            background=colors[1],
            foreground=colors[6],
            font='RobotoMono',
            fontsize=12,
            max_chars=60
        ),
        # widget.Spacer(),
    ]

    widget_list_mid = [
    ]

    widget_list_right = [
        widget.Sep(
            background=colors[1],
            foreground=colors[5],
            linewidth=1,
            padding=10
        ),
        widget.TextBox(
            background=colors[1],
            font='RobotoMono Nerd Font',
            fontsize=14,
            foreground=colors[6],
            padding=0,
            text=' '
        ),
        widget.KeyboardLayout(
            background=colors[1],
            font='RobotoMono',
            configured_keyboard=['ru', 'us'],
            fontsize=12,
            foreground=colors[6]
        ),
        widget.CapsNumLockIndicator(
            background=colors[1],
            font='RobotoMono',
            fontsize=12,
            foreground=colors[6]
        ),
        widget.Sep(
            background=colors[1],
            foreground=colors[5],
            linewidth=1,
            padding=10
        ),
        widget.TextBox(
            background=colors[1],
            font='RobotoMono Nerd Font',
            fontsize=14,
            foreground=colors[6],
            padding=0,
            text=' '
        ),
        widget.Clock(
            background=colors[1],
            font='RobotoMono',
            fontsize=12,
            foreground=colors[6],
            format='%a %d, (%B) %H:%M:%S '
        ),
    ]

    if monitor == 1:
        widget_list_unique = [
            widget.Systray(
                background=colors[1],
                icon_size=20,
                padding=4
            ),
            widget.Sep(
                background=colors[1],
                foreground=colors[5],
                linewidth=1,
                padding=10
            ),
            widget.TextBox(
                background=colors[1],
                font='RobotoMono Nerd Font',
                fontsize=14,
                foreground=colors[6],
                padding=0,
                text=' '
            ),
            widget.Backlight(
                background=colors[1],
                font='RobotoMono',
                fontsize=12,
                backlight_name='intel_backlight',
                foreground=colors[6],
                update_interval=0.2
            ),
        ]
    elif monitor == 2:
        widget_list_unique = [
            widget.CheckUpdates(
                background=colors[1],
                colour_have_updates=colors[10],
                foreground=colors[6],
                fontsize=12,
                linewidth=1,
                padding=10,
                no_update_string='No updates',
                font='RobotoMono',
                distro='Arch',
                custom_command='checkupdates; yay -Qua',
                mouse_callbacks={
                    'Button1': spawn_float_term(['yay', '-S', 'u', 'y', '--noconfirm'])
                },
            ),
        ]

    return widget_list_left + widget_list_mid + widget_list_unique + widget_list_right


def init_bottom_widgets_list():
    return [
        widget.Spacer(),
        widget.Sep(
            background=colors[1],
            foreground=colors[5],
            linewidth=1,
            padding=10
        ),
        widget.TextBox(
            background=colors[1],
            font='RobotoMono Nerd Font',
            fontsize=14,
            foreground=colors[6],
            padding=0,
            text=' '
        ),
        widget.ThermalSensor(
            background=colors[1],
            font='RobotoMono',
            fontsize=12,
            foreground=colors[6],
            tag_sensor='Package id 0',
            update_interval=0.2
        ),
        widget.Sep(
            background=colors[1],
            foreground=colors[5],
            linewidth=1,
            padding=10
        ),
        widget.TextBox(
            background=colors[1],
            font='RobotoMono Nerd Font',
            fontsize=14,
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn('alacritty -e htop -s PERCENT_MEM')
            },
            foreground=colors[6],
            padding=0,
            text=' '
        ),
        widget.Memory(
            background=colors[1],
            font='RobotoMono',
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn('alacritty -e htop -s PERCENT_MEM')
            },
            fontsize=12,
            format='{MemUsed: .2f}{mm}/{MemTotal: .2f}{mm}',
            foreground=colors[6],
            measure_mem='G'
        ),
        widget.MemoryGraph(
            type='line',
            line_width=1,
            graph_color=colors[8],
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn('alacritty -e htop -s PERCENT_MEM')
            },
            border_width=0,
            samples=1000
        ),
        widget.Sep(
            background=colors[1],
            foreground=colors[5],
            linewidth=1,
            padding=10
        ),
        widget.TextBox(
            background=colors[1],
            font='RobotoMono Nerd Font',
            fontsize=14,
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn('alacritty -e htop -s PERCENT_CPU')
            },
            foreground=colors[6],
            padding=0,
            text=' '
        ),
        widget.CPU(
            background=colors[1],
            font='RobotoMono',
            fontsize=12,
            foreground=colors[6],
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn('alacritty -e htop -s PERCENT_CPU')
            },
            format='CPU {load_percent}%',
            update_interval=1
        ),
        widget.CPUGraph(
            type='line',
            line_width=1,
            graph_color=colors[5],
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn('alacritty -e htop -s PERCENT_CPU')
            },
            border_width=0,
            samples=1000
        ),
        widget.Sep(
            background=colors[1],
            foreground=colors[5],
            linewidth=1,
            padding=10
        ),
        widget.TextBox(
            background=colors[1],
            font='RobotoMono Nerd Font',
            fontsize=14,
            foreground=colors[6],
            padding=0,
            text='  '
        ),
        widget.Net(
            background=colors[1],
            font='RobotoMono',
            fontsize=12,
            foreground=colors[5],
            format='{interface}: {down} ↓ ',
            interface='all',
            padding=0
        ),
        widget.Sep(
            background=colors[1],
            foreground=colors[5],
            linewidth=1,
            padding=10
        ),
        widget.Battery(
            background=colors[1],
            charge_char='',
            discharge_char='',
            empty_char='',
            unknown_char='',
            font='RobotoMono',
            format='{char}  {percent:2.0%}',
            fontsize=12,
            foreground=colors[5],
            padding=0
        ),
        widget.Sep(
            background=colors[1],
            foreground=colors[5],
            linewidth=1,
            padding=10
        ),
    ]


screens = [
    Screen(
        top=bar.Bar(widgets=init_widgets_list(1), opacity=1, size=20),
        bottom=bar.Bar(
            widgets=init_bottom_widgets_list(),
            opacity=1,
            size=20
        )
    ),
    Screen(top=bar.Bar(widgets=init_widgets_list(2), opacity=1, size=20)),
]

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button1", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),
        Match(wm_class="makebranch"),
        Match(wm_class="maketag"),
        Match(wm_class="ssh-askpass"),
        Match(title="branchdialog"),
        Match(title="pinentry"),
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True

wmname = "LG3D"
