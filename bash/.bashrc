#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# eval "$(zoxide init bash)"
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias brightnessctl='brightnessctl --min-value=1000'
alias conserve-battery-on="sudo sh -c 'echo 1 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode'"
alias conserve-battery-off="sudo sh -c 'echo 0 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode'"
PS1='[\u@\h \W]\$ '
export PATH="$PATH:$HOME/bin/"
