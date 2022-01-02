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
    new_w,new_h= 80,80
    
    palette_hex = ["0x808080","0xf3f1f3","0x201c18","0xfffbef","0x3b3b3b","0x54657b","0xaa3e49","0x767778","0xbe3647","0xfff78f","0x505050","0x535c74","0xdfc5ae","0x9ea7af","0x000000","0xffffff"]
    #linbo =   ["0xf9f1e9","0xc25f4f","0x686554","0xd7c1b2","0x455273","0xffd1c0","0xf19a3e","0x362e3e","0x8594a5","0xf4f0e8","0x505050","0x535c74","0x808080","0x9ea7af","0x000000","0xffffff"]
    #yingrui palette_hex = ["0x695871","0x808080","0xefe7e7","0x694a82","0x4d5ea2","0xa5a3a2","0xfed9d2","0x9e7d64","0x474757","0x6f4d90","0x544058","0x322a4c","0xeee7e7","0x9ea7af","0x000000","0xffffff"] #yingrui
    # palette_hex = ["0x695871","0x808080","0xefe7e7","0x694a82","0x4d5ea2","0xa5a3a2","0xfed9d2","0x9e7d64","0x474757","0x6f4d90","0x544058","0x322a4c","0xeee7e7","0x9ea7af","0x000000","0xffffff"]

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
