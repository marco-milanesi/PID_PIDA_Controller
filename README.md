<a name="readme-top"></a>

[![View PID GA Tuning on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/72999-fsda)
![GitHub top language](https://img.shields.io/github/languages/top/marco-milanesi/PID-PIDA-GAtuning)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/marco-milanesi/PID-PIDA-GAtuning)

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/othneildrew/Best-README-Template">
    <img src="README_images/PID_GA_tuning_logo.png" alt="Logo" width="30%">
    <h1 align="center">PID GA Tuning Toolbox</h3>
  </a>

  

  <p align="center">
    PID, PI-D, I-PD and PIDA genetic algorithm parameters optimization made easy with this GUI!
    <br />
    <a href="https://github.com/othneildrew/Best-README-Template"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/othneildrew/Best-README-Template">View Demo</a>
    ·
    <a href="https://github.com/othneildrew/Best-README-Template/issues">Report Bug</a>
    ·
    <a href="https://github.com/othneildrew/Best-README-Template/issues">Request Feature</a>
  </p>
</div>




![final_gui](https://github.com/marco-milanesi/PID-PIDA-GAtuning/assets/47824890/939604b2-0b56-4314-8087-ebadf6ae8aef)


* * * 

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about">About</a></li>
    <li><a href="#features">Features</a></li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>


## About
PID GA Tuning Toolbox is a Toolbox for

<p align="right">(<a href="#readme-top">back to top</a>)</p>


## Features

PID GA Tuning Toolbox includes the following features:
  
## MATLAB® Toolbox Installation
Follow the steps below to install _FEATool_ as a MATLAB® toolbox, and
to enable running MATLAB® simulation m-scripts

1) Download the
   [CFDTool.mlappinstall](https://github.com/precise-simulation/cfdtool/releases/latest/download/CFDTool.mlappinstall)
   toolbox installation file.

2) Then start MATLAB®, press the **APPS** toolbar button,
   and select the **Install App** button.

3) When prompted to choose a toolbox file to install, select the
   **CFDTool.mlappinstall** file and press **OK**.

4) Press the **Install** button if prompted to _"Install to My Apps"_.

![installation](https://github.com/marco-milanesi/PID-PIDA-GAtuning/assets/47824890/6cb693f4-b51a-4e83-a242-c6b1eeeb633a)


Once the toolbox has been installed, an app icon will be available in
the _APPS_ toolbar to start the _CFDTool_ GUI. (Note that MATLAB® may
not show or give any indication of the toolbox installation progress
or completion.)

## Basic Use

## Documentation

## Type of Controllers

### PID Controller
-------------------------------------------------

![](data/image/PID%20-%20PIDA%20Controller.png)

![](https://latex.codecogs.com/gif.latex?%5Cdpi%7B120%7D%20C%28s%29%3D%20K_%7Bp%7D%5Cleft%20%28%201&plus;%5Cfrac%7B1%7D%7BsT_%7Bi%7D%7D%20&plus;%5Cfrac%7BsT_%7Bd%7D%7D%7B1&plus;%5Cfrac%7BT_%7Bd%7D%7D%7BN%7Ds%7D%20%5Cright%20%29)

![](https://latex.codecogs.com/gif.latex?%5Cdpi%7B120%7D%20%5Cfrac%7BY%7D%7BY_%7Bsp%7D%7D%20%3D%20%5Cfrac%7BGC%7D%7B1&plus;GC%7D)

![](https://latex.codecogs.com/gif.latex?%5Cdpi%7B120%7D%20%5Cfrac%7BY%7D%7BD%7D%20%3D%20%5Cfrac%7BG%7D%7B1&plus;GC%7D)

### PI-D Controller
-------------------------------------------------
Proportional and Integral action is applied to the control error while Derivative action is applied to the process variable.

![](data/image/PI-D-Controller.png)

![](https://latex.codecogs.com/gif.latex?%5Cdpi%7B120%7D%20C_%7B1%7D%28s%29%3D%20K_%7Bp%7D)

![](https://latex.codecogs.com/gif.latex?%5Cdpi%7B120%7D%20C_%7B2%7D%28s%29%3D%20%5Cfrac%7BK_%7Bp%7D%7D%7BsT_%7Bi%7D%7D)

![](https://latex.codecogs.com/gif.latex?C_3%28s%29%3D%20%5Cfrac%7Bs%5C%2CT_d%5C%2CK_p%7D%7B%201&plus;%20%5Cfrac%7BT_d%7D%7BN%7Ds%7D)

![](https://latex.codecogs.com/gif.latex?%5Cfrac%7BY%7D%7BY_%7Bsp%7D%7D%3D%20%5Cfrac%7B%28C_1%20&plus;%20C_2%29%5C%2CG%7D%7B1&plus;%20G%5C%2C%28C_1%20&plus;%20C_2%20&plus;%20C_3%29%7D)

![](https://latex.codecogs.com/gif.latex?%5Cfrac%7BY%7D%7BD%7D%3D%20%5Cfrac%7BG%7D%7B1&plus;%20%28C_1%20&plus;%20C_2%20&plus;%20C_3%29%20G%7D)


### I-PD Controller
-------------------------------------------------
Integral action is applied to the control error while Proportional and Derivative action is applied to the process variable.

![](data/image/I-PD-Controller.png)

![](https://latex.codecogs.com/gif.latex?%5Cdpi%7B120%7D%20C_%7B1%7D%28s%29%3D%5Cfrac%7BK_%7Bp%7D%7D%7BsT_%7Bi%7D%7D)

![](https://latex.codecogs.com/gif.latex?%5Cdpi%7B120%7D%20C_%7B2%7D%28s%29%3DK_%7Bp%7D%20%5Cleft%20%28%201&plus;%5Cfrac%7BT_%7Bd%7Ds%7D%7B1&plus;%5Cfrac%7BT_%7Bd%7D%7D%7BN%7Ds%7D%20%5Cright%20%29)


![](https://latex.codecogs.com/gif.latex?%5Cfrac%7BY%7D%7BY_%7Bsp%7D%7D%3D%20%5Cfrac%7BC_1%20%5C%2CG%7D%7B1&plus;%20%28C_1%20&plus;%20C_2%29%20G%7D)


![](https://latex.codecogs.com/gif.latex?%5Cdpi%7B120%7D%20%5Cfrac%7BY%7D%7BD%7D%3D%5Cfrac%7BG%7D%7B1&plus;G%28C_%7B1%7D&plus;C_%7B2%7D%29%7D)



### PIDA Controller
-------------------------------------------------
![](data/image/PID%20-%20PIDA%20Controller.png)

![](https://latex.codecogs.com/gif.latex?C%28s%29%3D%20K_p%20%5Cleft%20%28%201%20&plus;%20%5Cfrac%7B1%7D%7BsT_i%7D&plus;%20%5Cfrac%7BsT_d%7D%7B1&plus;%5Cfrac%7BT_d%7D%7BN%7D%7D&plus;%20%5Cfrac%7Bs%5E2T_a%7D%7B%5Cleft%20%28%201%20&plus;%20%5Cfrac%7BsT_a%7D%7B%5Calpha%20%7D%20%5Cright%20%29%5E2%7D%20%5Cright%20%29)

![](https://latex.codecogs.com/gif.latex?%5Cdpi%7B120%7D%20%5Cfrac%7BY%7D%7BY_%7Bsp%7D%7D%20%3D%20%5Cfrac%7BGC%7D%7B1&plus;GC%7D)

![](https://latex.codecogs.com/gif.latex?%5Cdpi%7B120%7D%20%5Cfrac%7BY%7D%7BD%7D%20%3D%20%5Cfrac%7BG%7D%7B1&plus;GC%7D)


## Team


| <a href="https://marcomilanesi.com/" target="_blank">**Marco Milanesi**</a> | <a href="https://github.com/EdoGitMira" target="_blank">**Edoardo Mirandola**</a> |
| :---: |:---:|
| [![MarcoMilanesi](https://avatars.githubusercontent.com/u/47824890?v=3&s=200)](https://marcomilanesi.com/)  | [![Mirandola Edoardo]()](https://github.com/EdoGitMira)  |
| <a href="https://github.com/marco-milanesi" target="_blank">`github.com/marco-milanesi`</a> | <a href="https://github.com/EdoGitMira" target="_blank">`github.com/EdoGitMira`</a> |
