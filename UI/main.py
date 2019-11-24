import os
from tkinter import *
from PIL import Image, ImageTk
from tkinter import scrolledtext, Menu, filedialog, messagebox

def _from_rgb(rgb):
    return "#%02x%02x%02x" % rgb 

def load_file():
    filename  = filedialog.askopenfilename()
    img = ImageTk.PhotoImage(Image.open(filename))
    sourceImg = Canvas(root)
    sourceImg.place(relx = 0.01, rely = 0.05, relwidth = 0.35, relheight = 0.5)
    sourceImg.create_image(20,20, anchor = NW, image=img)
    sourceImg.image = img

def displayHexagon():
    filename  = "hexagon.png"
    img = Image.open(filename)
    image = img.resize((100,50),Image.ANTIALIAS)
    img=ImageTk.PhotoImage(image)
    detectionImg = Canvas(root)
    detectionImg.place(relx = 0.38, rely = 0.05, relwidth = 0.4, relheight = 0.5)
    detectionImg.create_image(20,20, anchor = NW, image=img)
    detectionImg.image = img

def displayPentagon():
    filename  = "pentagon.png"
    img = ImageTk.PhotoImage(Image.open(filename))
    detectionImg = Canvas(root)
    detectionImg.place(relx = 0.38, rely = 0.05, relwidth = 0.4, relheight = 0.5)
    detectionImg.create_image(20,20, anchor = NW, image=img)
    detectionImg.image = img

def displayQuadrilateral():
    filename  = "Qudrilateral.png"
    img = ImageTk.PhotoImage(Image.open(filename))
    detectionImg = Canvas(root)
    detectionImg.place(relx = 0.38, rely = 0.05, relwidth = 0.4, relheight = 0.5)
    detectionImg.create_image(20,20, anchor = NW, image=img)
    detectionImg.image = img

def displayTriangle():
    filename  = "triangle.png"
    img = Image.open(filename)
    image = img.resize((100,50),Image.ANTIALIAS)
    img=ImageTk.PhotoImage(image)
    detectionImg = Canvas(root)
    detectionImg.place(relx = 0.38, rely = 0.05, relwidth = 0.4, relheight = 0.5)
    detectionImg.create_image(20,20, anchor = NW, image=img)
    detectionImg.image = img

def displayRule():
    os.system('python showRule.py')

def displayFact():
    os.system('python showFacts.py')
    
def ruleEditor():
    os.system('python ruleEditor.py')

HEIGHT = 500
WIDTH = 800
root = Tk()

canvas = Canvas(root, height = HEIGHT, width = WIDTH, bg = _from_rgb((230, 230, 230)))
canvas.pack()

detectionResult = Frame(root,bg = 'white')
detectionResult.place(relx = 0.01, rely = 0.62, relwidth = 0.315, relheight = 0.44)

matchedFacts = Frame(root,bg = 'white')
matchedFacts.place(relx = 0.343, rely = 0.62, relwidth = 0.315, relheight = 0.4)

hitRules = Frame(root,bg = 'white')
hitRules.place(relx = 0.68, rely = 0.62, relwidth = 0.315, relheight = 0.4)

sourceImg = Frame(root,bg = 'white')
sourceImg.place(relx = 0.01, rely = 0.05, relwidth = 0.35, relheight = 0.5)

detectionImg = Frame(root,bg = 'white')
detectionImg.place(relx = 0.38, rely = 0.05, relwidth = 0.4, relheight = 0.5)

frame = Frame(root, bg =_from_rgb((230, 230, 230)))
frame.place(relx = 0.8, rely = 0.05, relwidth = 0.25, relheight = 0.5)

label1 = Label(root, text = "Source Image")
label1.place(relx=0.1, rely=0.0)

label2 = Label(root, text = "Detection Iamge")
label2.place(relx=0.5, rely=0.0)

label3 = Label(root, text = "Detection Result")
label3.place(relx=0.1, rely=0.575)

label4 = Label(root, text = "Matched Fact")
label4.place(relx=0.457, rely=0.575)

label5 = Label(root, text = "HIt Rules")
label5.place(relx=0.8, rely=0.575)

openImage = Button(frame, text = "Open Source",command = load_file, width=15, height=1, bg = 'white').place(x=25 ,y=0)

openRuleEditor = Button(frame, text = "Open Rule Editor",command = ruleEditor,width=15, height=1,bg = 'white').place(x=25 ,y=35)

showRule =Button(frame, text = "Show Rule",command = displayRule,width=15, height=1,bg = 'white').place(x=25 ,y=70)

showFact =Button(frame, text = "Show Fact",command = displayRule,width=15, height=1,bg = 'white').place(x=25 ,y=105)

frame1 = Frame(root, bg = 'yellow')
frame1.place(relx = 0.78, rely = 0.35, relwidth = 0.25, relheight = 0.2)

def dbclick(event):
    if l.get('active') == "triangle":
        displayTriangle()
    if l.get('active') == "quadrilateral":
        displayQuadrilateral()
    if l.get('active') == "pentagon":
        displayPentagon()
    if l.get('active') == "hexagon":
        displayHexagon()
        
   

l = Listbox(frame1)
l.insert(1, "triangle")
l.insert(2, "quadrilateral")
l.insert(3, "pentagon")
l.insert(4, "hexagon")
l.pack()
l.focus()


def print_me():
    if(l.curselection == 1):
        print("ljljlili")

print_me()
l.bind('<Double-1>', dbclick)

root.mainloop()
