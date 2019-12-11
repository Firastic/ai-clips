import cv2
import numpy as np
import math
from copy import deepcopy

marked_image = 0
def is_outer_rectangle(vertices, x, y):
    if(len(vertices) != 8):
        return False
    if(vertices[0] != vertices[2] or vertices[3] != vertices[5] or vertices[4] != vertices[6] or vertices[7] != vertices[1]):
        return False
    if(vertices[3] - vertices[1] + 1 != y or vertices[4] - vertices[2] + 1 != x):
        return False
    return True

def get_shape_vertices(img, thresh):
    global marked_image
    contours, _ = cv2.findContours(thresh, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
    marked_image = deepcopy(img)
    for cnt in contours:
        approx = cv2.approxPolyDP(cnt, 0.05*cv2.arcLength(cnt, True), True)
        if(not is_outer_rectangle(approx.flatten(), len(img[0]), len(img))):
            cv2.drawContours(marked_image, [approx], -1, (0, 255, 0), 2)
            print('dah diwrite')
            cv2.imwrite('../temp/marked_image.jpg', marked_image)
            return approx

def convert_to_tuple(vertices):
    vertices = vertices.flatten()
    arr = []
    for i in range(0, len(vertices), 2):
        arr.append((vertices[i], vertices[i+1]))
    return arr

def calc_angle(a, b, c):
    ang = math.degrees(math.atan2(c[1]-b[1], c[0]-b[0]) - math.atan2(a[1]-b[1], a[0]-b[0]))
    return ang + 360 if ang < 0 else ang

def get_length(a, b):
    return math.sqrt((a[0]-b[0])*(a[0]-b[0]) + (a[1]-b[1])*(a[1]-b[1]))

def get_line(vertices):
    arr = []
    for i in range(len(vertices)):
        arr.append(get_length(vertices[i], vertices[(i+1)%len(vertices)]))
    return arr

def get_angle(vertices):
    angle_array = []
    for i in range(len(vertices)):
        c = vertices[(i-1)%len(vertices)]
        b = vertices[i]
        a = vertices[((i+1)+len(vertices))%len(vertices)]
        angle_array.append(calc_angle(a,b,c))
    return angle_array

def create_facts(filename):
    font = cv2.FONT_HERSHEY_COMPLEX
    img = cv2.imread(filename)

    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    gray = cv2.GaussianBlur(gray, (5, 5), 0)

    thresh = cv2.threshold(gray, 100, 255, cv2.THRESH_BINARY)[1]
    thresh = cv2.erode(thresh, None, iterations=2)
    thresh = cv2.dilate(thresh, None, iterations=2)

    vertices = get_shape_vertices(img, thresh)
    print(vertices)
    vertices = convert_to_tuple(vertices)
    #print(vertices)
    #print("Vertices count: ", len(vertices))

    angle_array = get_angle(vertices)
    #print(angle_array)

    line_array = get_line(vertices)
    #print(line_array)

    fact = []
    for i in range(len(vertices)):
        fact.append(['point', i+1, vertices[i][0], vertices[i][1], angle_array[i], line_array[i]])
    fact.append(['totalPoint', len(vertices)])
    #print(fact)
    return fact

if __name__ == '__main__':
    create_facts("../img/shape/segiempat.jpg")