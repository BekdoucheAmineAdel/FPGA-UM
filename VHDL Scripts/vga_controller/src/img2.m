%--------------------------------------------------------------------------
% Company: University of Montpellier
% Engineer: Bekdouche Amine Adel
%
% Create Date: 2025-06-07
% Design Name: M2-FPGA
% Module Name: IMG2coe8 - MATLAB Function
% Project Name: FPGA Crash Course
% Tool Versions: MATLAB R2023b (or your actual version)
% Description:
% This MATLAB function converts a color image (.bmp or .jpg) into a .coe
% file suitable for initializing block memory in an FPGA. The output file
% contains 8-bit pixel values encoded in a custom RGB format:
% [R2 R1 R0 G2 G1 G0 B1 B0].
%
% Inputs:
% - imgfile: Path to the input image file (.bmp or .jpg)
% - outfile: Path to the output .coe file
%
% Outputs:
% - img2: Processed image with reduced color depth (for visualization)
%
% Dependencies:
% - MATLAB Image Processing Toolbox
%
% Revision:
% Revision 0.01 - File Created
% Additional Comments:
% The function is designed for use with VGA display systems in FPGA
% projects. It reduces color depth to fit 8-bit memory constraints.
%--------------------------------------------------------------------------
function img2 = IMG2coe8(imgfile, outfile) 
% Create .coe file from .bmp .jpg image 
% .coe file contains 8-bit words (bytes) 
% each byte contains one 8-bit pixel 
% color byte: [R2,R1,R0,G2,G1,G0,B1,B0] 
% img2 = IMG2coe8(imgfile, outfile) 
% img2 is 256-bit color image 
% imgfile = input .bmp file / .jpg 
% outfile = output .coe file 
% Example:
% img2 = IMG2coe8('image.jpg', 'image.coe'); 
  
img = imread(imgfile); 
height = size(img, 1); 
width = size(img, 2); 

s = fopen(outfile,'wb');  %opens the output file 

fprintf(s,'%s\n','; VGA Memory Map '); 
fprintf(s,'%s\n','; .COE file with hex coefficients '); 
fprintf(s,'; Height: %d, Width: %d\n\n', height, width); 
fprintf(s,'%s\n','memory_initialization_radix=16;');  
fprintf(s,'%s\n','memory_initialization_vector='); 

cnt = 0;
img2 = img; 
for r=1:height 
    for c=1:width 
        cnt = cnt + 1; 
        R = img(r,c,1); 
        G = img(r,c,2); 
        B = img(r,c,3); 
        Rb = dec2bin(double(R),8); 
        Gb = dec2bin(double(G),8); 
        Bb = dec2bin(double(B),8); 
        img2(r,c,1) = bin2dec([Rb(1:3) '00000']); 
        img2(r,c,2) = bin2dec([Gb(1:3) '00000']); 
        img2(r,c,3) = bin2dec([Bb(1:2) '000000']); 
        Outbyte = [ Rb(1:3) Gb(1:3) Bb(1:2) ]; 
        if (Outbyte(1:4) == '0000') 
            fprintf(s,'0%X',bin2dec(Outbyte)); 
        else 
            fprintf(s,'%X',bin2dec(Outbyte)); 
        end 
        if ((c == width) && (r == height)) 
            fprintf(s,'%c',';'); 
        else 
            if (mod(cnt,32) == 0) 
                fprintf(s,'%c\n',','); 
            else 
                fprintf(s,'%c',','); 
            end 
        end 
    end 
end 
  
fclose(s);
