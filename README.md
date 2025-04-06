# IMAGE-PROCESSING-USING-EDGE-SOBEL-DETECTION-AND-CANNY-EDGE-DETECTION-ON-ZEDBOARD-FPGA
This project aims to create custom IP's for Edge Sobel and Canny edge detection for Zedboard. For testing its functionality we use a 512*512 bmp image as input. The code for both IP's are written in verilog language. At last both IP's are compared and analyzed based on its edge detection accuracy, power utilization and resource utilization on FPGA.

#SOFTWARES
HDL - VIVADO 2017.4
C - SDK

#TESTING
The edge sobel detection IP was tested using the bmp image which was stored inside DDR of Zedboard and after processing the output was displayed on a monitor (thanks to Vipin Kizhepatt sir for his youtube tutorials).Both verilog and C is used for coding the PL and PS part of Zedboard.Canny edge detection was tested using the same n=bmp image which is send to FPGA using UART interface and recieving the processed pixels.The edge detection accuracy was found using python by comparing both edge detected image with a ground truth image as reference.

Both Verilog and C code for both IP'S are provided.Both IP's were also simulated successdully using different BMP images. 
