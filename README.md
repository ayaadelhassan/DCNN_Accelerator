<p align="center">
  <a href="" rel="noopener">
 <img width=400px height=210px src="https://svgur.com/i/Xav.svg" alt="logo"></a>
</p>

<p align="center"> A DCNN accelator chip that operates on grayscale images
    <br> 
</p>

<p align="center">
  <a href="https://github.com/ayaadelhassan/DCNN_Accelerator/graphs/contributors" alt="Contributors">
        <img src="https://img.shields.io/github/contributors/ayaadelhassan/DCNN_Accelerator" /></a>
  
   <a href="https://github.com/ayaadelhassan/DCNN_Accelerator/issues" alt="Issues">
        <img src="https://img.shields.io/github/issues/ayaadelhassan/DCNN_Accelerator" /></a>
  
  <a href="https://github.com/ayaadelhassan/DCNN_Accelerator/network" alt="Forks">
        <img src="https://img.shields.io/github/forks/ayaadelhassan/DCNN_Accelerator" /></a>
        
  <a href="https://github.com/ayaadelhassan/DCNN_Accelerator/stargazers" alt="Stars">
        <img src="https://img.shields.io/github/stars/ayaadelhassan/DCNN_Accelerator" /></a>
        
  <a href="https://github.com/ayaadelhassan/DCNN_Accelerator/blob/master/LICENSE" alt="License">
        <img src="https://img.shields.io/github/license/ayaadelhassan/DCNN_Accelerator" /></a>
</p>

---

## 📝 Table of Contents

- [About](#about)
- [Design](#design)
- [Tools](#tech)

## 🧐 About <a name = "about"></a>

A detailed low-level design of a DCNN accelerator chip that applies a CNN classifier over a grayscaled image (MNIST handwritten digits dataset). The chip is a stand-alone chip that reads the image & CNN layers from user, applies the layers (convolution / pooling) consequently, and generates the output label (0 - 9).

<p align="center">
  <a href="" rel="noopener">
 <img src="https://i.ibb.co/D7wdc8H/Screenshot-20210527-231304.png" alt="About"></a>
</p>

## :electron: Design <a name = "design"></a>
The process is divided into 3 modules:
1. Loading the image & CNN layers (IO Module)
    * Loading the image & CNN info into the accelerator RAM will be done using compressing (SW) and passing the compressed files using a parallel port (16-bit), then your hardware will uncompress the data and save it in its designated locations.

2. Applying Layers one by one (CNN Module):
    * Applying the layers will start after the loading step is done (a done signal is passed from module 1 to module 2). 
    * The CNN layers are applied consecutively (Layer1 is applied & its result is saved in the RAM, then layer2 is applied & its result is also saved in the RAM, and so on).

3. Applying fully connected layer and out the label (FC Module): 
    * Finally, the last layer is a fully connected layer that is applied on the last CNN layer to generate the classification label.


### :electric_plug: IO Module
<p align="center">
  <a href="" rel="noopener">
    <img src="https://i.ibb.co/grVHWbd/Screenshot-20210527-232019.png" alt="IODesign1"></a><br> <br>
  <img src="https://i.ibb.co/d5wP0KY/Screenshot-20210527-232035.png" alt="IODesign2"></a>
</p>

### :computer: CNN Module
<p align="center">
  <a href="" rel="noopener">
    <img src="https://i.ibb.co/Tc5C297/Design-1.png" alt="CNNDesign1"></a><br> <br>
    <img src="https://i.ibb.co/wStXt43/Design.png" alt="CNNDesign2"></a><br> <br>
    <img src="https://i.ibb.co/KDLJDz2/Pooling.png" alt="CNNDesign3"></a>
</p>

### :outbox_tray: FC Module

## ⛏️ Built Using <a name = "tech"></a>

- [Verilog](https://en.wikipedia.org/wiki/Verilog)
- [SystemVerilog](https://en.wikipedia.org/wiki/SystemVerilog)
- [ModelSim](https://www.intel.com/content/www/us/en/software/programmable/quartus-prime/model-sim.html)
- [Python](https://www.python.org/)
