from tkinter import *
from tkinter import scrolledtext, Menu, filedialog, messagebox

root = Tk(className="Rule Editor")
textPad = scrolledtext.ScrolledText(root, width=100, height=80)

def open_command():
    file = open('text.txt').read()
    if file != None:
        textPad.Insert('1.0', file)

def save_command():
    f = open('text.txt','w+')
    data = str(textPad.get('1.0', END))
    f.write(data)
    f.close()
    root.destroy()

def exit_command():
    if messagebox.askokcancel("quit", "BEneran mau caw?"):
        root.destroy()


menu = Menu(root)
root.config(menu=menu)
filemenu = Menu(menu)
open_command
menu.add_cascade(label="File", menu=filemenu)
filemenu.add_command(label = "save", command = save_command)
filemenu.add_command(label = "exit", command = exit_command)

textPad.pack()
root.mainloop()