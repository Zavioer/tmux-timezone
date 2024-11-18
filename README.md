# Tmux Timezone

Quickly check time in different timezones directly from tmux.


## Installation

You can use [TPM](https://github.com/tmux-plugins/tpm), add the following line to your `.tmux.conf` file:

```bash
set -g @plugin 'Zavioer/tmux-timezone'
```


## Usage


### Keybindings

- `<tmux-prefix> C-t` display plugin main menu
- `<tmux-prefix> M-t` show time in selected timezones 


### First run


To proper configure plugin you must follow this steps:

1. Open main menu and select `Add` option.
2. Enter timezone using [Continet/City](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List) identifier.

> You can add up to 3 timezones.


## Configuration


Time display format accepts options for [date](https://man7.org/linux/man-pages/man1/date.1.html) command. 

```bash
set -g @timezone_date_format "%D %H:%M:%S %Z"
```


## Contributing


Feel free to raise requests for new features or improvements.


## License
MIT
