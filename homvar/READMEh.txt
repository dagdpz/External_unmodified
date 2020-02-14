HOMVAR gives several homoscedasticity tests as Bartlett, Cochran, Brown-Forsythe, Levene,
O'Brien and Welch to choose from any of the following functions: Btest, Cochtest, BFtest,
Levenetest, OBrientest and Wtest.

-------------------------------------------------------------
Created by A. Trujillo-Ortiz and R. Hernandez-Walls
           Facultad de Ciencias Marinas
           Universidad Autonoma de Baja California
           Apdo. Postal 453
           Ensenada, Baja California
           Mexico.
           atrujo@uabc.mx

May 15, 2003.

To cite this file, this would be an appropriate format:
Trujillo-Ortiz, A. and R. Hernandez-Walls. (2003). Homvar: Homogeneity of variances
  tests menu. A MATLAB file. [WWW document]. URL http://www.mathworks.com/matlabcentral/
  fileexchange/loadFile.do?objectId=3510&objectType=FILE
-------------------------------------------------------------
Congratulations on deciding to use this MATLAB macro file.  
This program has been developed to help you quickly calculate the
homoscedasticity tests without hassles.
-------------------------------------------------------------
This zip file is free; you can redistribute it and/or modify at your option.
-------------------------------------------------------------
This zip file contains....
	List of files you should need

Homvar.m        Homoscedasticity tests menu to choose
Btest.m         Bartlett test
Cochtest.m      Cochran test
BFtest          Brown-Forsythe test
Levenetest      Levene test
OBrientest      O'Brien test
Wtest           Welch test
cochcdf         Cochran's cumulative distribution function
READMEh.TXT		
-------------------------------------------------------------
Usage

1. It is necessary you have defined on Matlab the X - data matrix 
(Size of matrix must be n-by-2; data=column 1, sample=column 2). 

2. For running this file it is necessary to call the Homvar function as Homvar(X,alpha)
(alpha-significance level default = 0.05). Please see the help Homvar.

3. Immediately it will ask you by directed arguments which is your 
homoscedasticity test of interest. 

4. Once you input your choices, it will appears your results.
-------------------------------------------------------------
We claim no responsibility for the results that are obtained 
from your data using this file.
-------------------------------------------------------------
Copyright.2003