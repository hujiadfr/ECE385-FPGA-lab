from PIL import Image
from collections import Counter
from scipy.spatial import KDTree
import numpy as np
import os
def hex_to_rgb(num):
    h = str(num)
    return int(h[0:4], 16), int(('0x' + h[4:6]), 16), int(('0x' + h[6:8]), 16)
def rgb_to_hex(num):
    h = str(num)
    return int(h[0:4], 16), int(('0x' + h[4:6]), 16), int(('0x' + h[6:8]), 16)
files=os.listdir("./sprite_originals/")
for filename in files:
    # filename = input("What's the image name? ")
    # new_w, new_h = map(int, input("What's the new height x width? Like 28 28. ").split(' '))
    new_w,new_h=40,40
    palette_hex = ["0xfff3dc","0xccc1d3","0xae3f4c","0x808080","0x020101","0x00ff00","0xf0ccaf","0xfffbeb","0x766c96","0xe3998a","0x59667f","0x535c74","0xab9b9e","0xdfe5eb","0x000000","0xffffff"]
    palette_rgb = [hex_to_rgb(color) for color in palette_hex]

    pixel_tree = KDTree(palette_rgb)
    im = Image.open("./sprite_originals/" + filename) #Can be many different formats.
    im = im.convert("RGBA")
    im = im.resize((new_w, new_h),Image.ANTIALIAS) # regular resize
    pix = im.load()
    pix_freqs = Counter([pix[x, y] for x in range(im.size[0]) for y in range(im.size[1])])
    pix_freqs_sorted = sorted(pix_freqs.items(), key=lambda x: x[1])
    pix_freqs_sorted.reverse()
    print(pix)
    outImg = Image.new('RGB', im.size, color='white')
    outFile = open("./sprite_bytes/" + filename + '.txt', 'w')
    i = 0
    for y in range(im.size[1]):
        for x in range(im.size[0]):
            pixel = im.getpixel((x,y))
            print(pixel)
            if(pixel[3] < 200):
                outImg.putpixel((x,y), palette_rgb[0])
                outFile.write("%x\n" % (0))
                print(i)
            else:
                index = pixel_tree.query(pixel[:3])[1]
                outImg.putpixel((x,y), palette_rgb[index])
                outFile.write("%x\n" % (index))
            i += 1
    outFile.close()
    outImg.save("./sprite_converted/" + filename)
