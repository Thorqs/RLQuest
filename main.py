# Imports
from tkinter import *
from tkinter import ttk
#import os
#import glob
#import subprocess

# Make main window
root = Tk()
root.title("RLQuest - helping your win at the game of life, your way.")

mainframe = ttk.Frame(root, padding = (3, 3, 12 ,12))
mainframe.grid(column=0, row=0, sticky = (N, W, E, S))

## Default view should be what next -> get straight into it
# List of next steps
# -
# Buttons for quest log

## QUEST LOG
# Label for quest log
ttk.Label(mainframe, text="Quest Log")


ttk.Button(root, text="Hello World").grid()
root.mainloop()

# Ideally, each module has its own user interface, even if they may interact or extend each other
# This should be dynamically extendable with whatever the user has installed
# Essentially, the main file's job is to make a base-line UI and call other bits as needed

## Enumerate modules
#addons = glob.glob('*.py')
#addon_list = ""

#for addon in addons:
#	if addon != "main.py":
#		addon_list += addon + "\n"

#selection = input("What would you like to look at?\n" + addon_list + "Selection: ")

#subprocess.run(["py", selection])

