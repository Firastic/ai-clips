from tkinter import *
from tkinter import scrolledtext, Menu, filedialog, messagebox

def open_command():
    file = open('text.txt').read()
    if file != None:
        textPad.Insert('1.0', file)

def exit_command():
    if messagebox.askokcancel("quit", "BEneran mau caw?"):
        root.destroy

root = Tk(className="Show Rule")
textPad = scrolledtext.ScrolledText(root, width=100, height=80)
menu = Menu(root)
root.config(menu=menu)
filemenu = Menu(menu)
open_command
menu.add_cascade(label="File", menu=filemenu)
filemenu.add_command(label = "exit", command = open_command)
textPad.insert(1.0, "kaakak")
textPad.pack()
root.mainloop()