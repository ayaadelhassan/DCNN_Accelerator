import math
f = open("D:\college\cmp3\second\\vlsi\DCNN_Accelerator\IO\FCInfo\\biasesdense_2.txt", "r") #will be an input
f_out=open("D:\college\cmp3\second\\vlsi\DCNN_Accelerator\IO\\fixed_point_biasesFC2.txt","a")
numbers = []
for x in f:
  data = x.split() 
  for s in data:
      if s.find("--") == -1:
        if s.find("e") == -1:
            numbers.append(s)
        else:
            to_multiply = s[-1:]
            last_chars=s[-4:]
            number = s.replace(last_chars, '')
            number = float(number) * pow(10,-1*int(to_multiply))
            numbers.append(number)
for n in numbers:
    if n < 0:
        int_number=math.floor(n)
        frac_number=n-int_number
        int_number_bin= "1"+"{0:4b}".format(-1*int_number).replace(" ", "0")
        precision=11
        frac_number_bin=""
        while (precision):
            frac_number *= 2
            bit = int(frac_number)
            if (bit == 1) :   
                frac_number -= bit  
                frac_number_bin += '1'
            else : 
                frac_number_bin += '0'
            precision -= 1
        fixed_point_bin=str(int_number_bin)+str(frac_number_bin)
        f_out.write(fixed_point_bin)
        f_out.write(" ")

    else:
        int_number=math.ceil(n)
        frac_number=int_number-n
        int_number_bin= "0"+"{0:4b}".format(int_number).replace(" ", "0")
        precision=11
        frac_number_bin=""
        while (precision):
            frac_number *= 2
            bit = int(frac_number)
            if (bit == 1) :   
                frac_number -= bit  
                frac_number_bin += '1'
            else : 
                frac_number_bin += '0'
            precision -= 1
        fixed_point_bin=str(int_number_bin)+str(frac_number_bin)
        f_out.write(fixed_point_bin)
        f_out.write(" ")

        










