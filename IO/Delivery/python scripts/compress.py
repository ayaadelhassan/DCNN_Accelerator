import numpy as np
import cv2 as cv2

def RLE(array):
    n = len(array)
    i = 0
    encoded = ""
    while i < n - 1:
        count = 1
        while (i < n - 1 and
               array[i] == array[i + 1]):
            count += 1
            i += 1
        i += 1
        encoded += array[i - 1] + "{0:15b}".format(count).replace(" ", "0")+"\n"
        #print(encoded)
    return encoded
############################
def float_bin(number):
    whole, dec = str(number).split(".")
    whole = int(whole)
    dec = int(dec)
    dec= str(dec)
    res = "{0:5b}".format(whole).replace(" ", "0")
    if len(dec) < 11:
        while len(dec) < 11:
            dec = dec + '0'

    dec = int(dec)
    for x in range(11):
        whole, dec = str((decimal_converter(dec)) * 2).split(".")

        dec = int(dec)
        res += whole

    return res
def decimal_converter(num):
    if num == 0:
        num = 0.0

    while num > 1:
        num /= 10
    return num
############################
image = cv2.imread('test1.bmp',0)
dim=(32,32)
resized = cv2.resize(image, dim, interpolation = cv2.INTER_AREA)
divided = np.divide(resized,255)
print(float_bin(255/255))
#print("{0:5b}".format(int((spl.split('.'))[0])).replace("0b", ""))
w ,h = divided.shape
print(w,h)
data = np.array([np.array(image)])
pixels_binary_fixedpoint = ""
compressed = []
f = open("out.txt", "w")

for i in range(h):
    for j in range(w):
        binary_num = float_bin(divided[i][j])
        pixels_binary_fixedpoint += binary_num

print(len(pixels_binary_fixedpoint))
print(pixels_binary_fixedpoint)

compressed = RLE(pixels_binary_fixedpoint)
f.write(compressed)
f.close()
#ready to decompress in verilog
