import os
from tkinter import *
from tkinter import ttk
from PIL import Image, ImageTk
from tkinter import scrolledtext, Menu, filedialog, messagebox
from analysis import *

class TextModified(Text):
    def setText(self, text):
        self.clear()
        self.tag_config("hasil", font = ("Calibri", 10), justify = 'left')
        self.insert(END, text)
        self.tag_add("center", "1.0", "end")
        self.pack()

    def clear(self):
        self.delete("1.0", END)

class FrameModified:
    def __init__(self, frame):
        self.frame = frame
        self.text = TextModified(frame)
        self.text.setText("Placeholder")

    def insert_text(self, message):
        self.text.setText(message)

def _from_rgb(rgb):
    return "#%02x%02x%02x" % rgb

def load_file():
    filename  = filedialog.askopenfilename()
    img = ImageTk.PhotoImage(Image.open(filename))
    sourceImg = Canvas(root)
    sourceImg.place(relx = 0.01, rely = 0.05, relwidth = 0.35, relheight = 0.5)
    sourceImg.create_image(20,20, anchor = NW, image=img)
    sourceImg.image = img
    analysis.load_image(filename)

def displayShape(nameShape):
    filename = '../img/shape/' + nameShape +'.jpg'
    img = Image.open(filename)
    image = img.resize((int(0.4*WIDTH),int(0.5*HEIGHT)),Image.ANTIALIAS)
    img=ImageTk.PhotoImage(image)
    detectionImg = Canvas(root)
    detectionImg.place(relx = 0.38, rely = 0.05, relwidth = 0.4, relheight = 0.5)
    detectionImg.create_image(0,0, anchor = NW, image=img)
    detectionImg.image = img
    show_analysis(nameShape)
    
def displayRule():
    os.system('python showRule.py')

def displayFact():
    os.system('python showFacts.py')
    
def ruleEditor():
    os.system('python ruleEditor.py')

def callback(event):
    displayShape(shape.selection()[0])

def initialize_analysis():
    global analysis
    analysis = Analysis('../shape-detector.clp')

    #analysis.run()
    #analysis.matched_facts()
    #analysis.hit_rules()
    #analysis.open_result_image()

def show_analysis(shape):
    global analysis, detectionResult, hitRules, matchedFacts
    analysis.run()
    hitRules.insert_text(analysis.hit_rules())
    matchedFacts.insert_text(analysis.matched_facts())
    detectionResult.insert_text(analysis.detection_results(shape))
    print("Shape: ", shape)

def insert_text(frame, message):
    text = Text(frame)
    text.pack_forget()
    text.tag_config("hasil", font = ("Calibri", 10), justify = 'left')
    text.insert("1.0", message, "hasil")
    text.tag_add("center", "1.0", "end")
    text.pack()

HEIGHT = 560
WIDTH = 1000
root = Tk()

canvas = Canvas(root, height = HEIGHT, width = WIDTH, bg = _from_rgb((230, 230, 230)))
canvas.pack()

detectionResultFrame = Frame(root,bg = 'white')
detectionResultFrame.place(relx = 0.01, rely = 0.62, relwidth = 0.315, relheight = 0.44)
detectionResult = FrameModified(detectionResultFrame)

matchedFactsFrame = Frame(root,bg = 'white')
matchedFactsFrame.place(relx = 0.343, rely = 0.62, relwidth = 0.315, relheight = 0.4)
matchedFacts = FrameModified(matchedFactsFrame)

hitRulesFrame = Frame(root,bg = 'white')
hitRulesFrame.place(relx = 0.68, rely = 0.62, relwidth = 0.315, relheight = 0.4)
hitRules = FrameModified(hitRulesFrame)

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

label5 = Label(root, text = "Hit Rules")
label5.place(relx=0.8, rely=0.575)

openImage = Button(frame, text = "Open Source",command = load_file, width=15, height=1, bg = 'white').place(x=25 ,y=0)

openRuleEditor = Button(frame, text = "Open Rule Editor",command = ruleEditor,width=15, height=1,bg = 'white').place(x=25 ,y=35)

showRule =Button(frame, text = "Show Rule",command = displayRule,width=15, height=1,bg = 'white').place(x=25 ,y=70)

showFact =Button(frame, text = "Show Fact",command = displayRule,width=15, height=1,bg = 'white').place(x=25 ,y=105)

frame1 = Frame(root, bg = _from_rgb((230, 230, 230)))
frame1.place(relx = 0.8, rely = 0.35, relwidth = 0.18, relheight = 0.2)

shape = ttk.Treeview(frame1)
style = ttk.Style()
style.configure("Treeview", font=(None, 8))
style.configure("Treeview.Heading", font=(None, 8))

shape.heading("#0",text="All Shapes",anchor=NW)
shape.insert('', '0', 'segitiga', text = "Segitiga")
shape.insert('segitiga', 'end', 'segitiga_lancip', text = "Segitiga lancip")
shape.insert('segitiga', 'end', 'segitiga_tumpul', text = "Segitiga tumpul")
shape.insert('segitiga', 'end', 'segitiga_siku', text = "Segitiga siku-siku")
shape.insert('segitiga', '4', 'item4', text = "Segitiga sama kaki")
shape.insert('item4', 'end', 'segitiga_samakaki_siku', text = "Segitiga sama kaki dan siku-siku")
shape.insert('item4', 'end', 'segitiga_samakaki_tumpul', text = "Segitiga sama kaki dan tumpul")
shape.insert('item4', 'end', 'segitiga_samakaki_lancip', text = "Segitiga sama kaki dan lancip")
shape.insert('segitiga', 'end', 'segitiga_samasisi', text = "Segitiga sama sisi")

shape.insert('', '1', 'segiempat', text = "Segiempat")
shape.insert('segiempat', '5', 'item9', text = "Jajar Genjang")
shape.insert('item9', 'end', 'segiempat_beraturan', text = "Segiempat beraturan")
shape.insert('item9', 'end', 'segiempat_layang', text = "Layang-layang")
shape.insert('segiempat', '6', 'item10', text = "Trapesium")
shape.insert('item10', 'end', 'segiempat_trapesium_samakaki', text = "Trapesium sama kaki")
shape.insert('item10', 'end', 'segiempat_trapesium_ratakanan', text = "Trapesium rata kanan")
shape.insert('item10', 'end', 'segiempat_trapesium_ratakiri', text = "Trapesium rata kiri")

shape.insert('', '2', 'segilima', text = "Segilima")
shape.insert('segilima', 'end', 'segilima_samasisi', text = "Segilima sama sisi")

shape.insert('', '3', 'segienam', text = "Segienam")
shape.insert('segienam', 'end', 'segienam_samasisi', text = "Segienam sama sisi")

shape.pack()

shape.bind('<<TreeviewSelect>>', callback)

initialize_analysis()

root.mainloop()
