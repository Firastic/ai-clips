from tkinter import *
from tkinter import scrolledtext, Menu, filedialog, messagebox

root = tkinter.Tk(className="Show Facts")
textPad = scrolledtext.ScrolledText(root, width=100, height=80)

def open_command():
    file = open('text.txt').read()
    if file != None:
        textPad.Insert('1.0', file)

def exit_command():
    if messagebox.askokcancel("quit", "BEneran mau caw?"):
        root.destroy

menu = Menu(root)
    root.config(menu=menu)
    filemenu = Menu(menu)
    open_command
    menu.add_cascade(label="File", menu=filemenu)
    filemenu.add_command(label = "exit", command = open_command)

textPad.pack()
root.mainloop()