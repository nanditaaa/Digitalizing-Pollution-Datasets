clc %for clearing the command window
clear all %for deleting all the variables from the memory
close all %for closing all the plots
fid = fopen('dcsda.txt'); %in order to open the text file, fopen fn is used.
x=fread(fid,'*char');% Fread function reads the file data into an array. 
% *char converts each string element of A to a character vector
% and then concatenates the vectors to produce a character array.
% automatically padded with blank spaces as needed. 
% Since char converts each string to a character vector
% the size of the output character array is different from the size of the string array.
% CONVERSION OF TEXT DATA INTO BINARY:
binary = dec2bin(x,8);  %The "dec2bin" function Converts decimal integer to its
%binary representation.This function returns the binary representation of x.
binary_t=transpose(binary); % The transpose function returns the nonconjugate transpose of binary variable.
% that is, interchanges the row and column index for each element
signal_1=binary_t(:)-'0'; %conversion of dataset to binary stream. 
% takes the threshold according to the dataset.
figure(1); %first page of plots.
plot(signal_1,'linewidth',2); %plotting the binary raw data in a line thickness of 2.
set(gca,'fontsize',13,'fontweight','bold'); %to enhance the figure boldness
title('Air Pollution Emissions dataset imported','fontsize',15,'fontweight','bold');
xlabel('Time','fontsize',12,'fontweight','bold'); %plot specifications
ylabel('Binarized magnitude of pollution emissions','fontsize',12,'fontweight','bold');
axis([0 50 -1.5 2]) %specifying axis of the dataset as the dataset is a real world information
% the size of the dataset is huge, hence plotting a portion
% of the dataset. 


figure(2) %second plot page.
stem(signal_1,'linewidth',2); %using stem function to plot the discrete amounts of emission over the time.
%this figure will help us to visualise accurately the points where the
%emissions are more than 2 i.e the binary digit 1. If else 0.
set(gca,'fontsize',13,'fontweight','bold'); %to enhance the figure boldness
title('Displaying discrete values of emissions ','fontsize',15,'fontweight','bold'); 
xlabel('Time','fontsize',12,'fontweight','bold'); %plot specifications
ylabel('Magnitude','fontsize',12,'fontweight','bold');
axis([0 50 -1.5 2])  %specifying axis of the dataset as the dataset is a real world information
% the size of the dataset is huge, hence plotting a portion
% of the dataset. 


% PROCESS OF QUANTIZATION OF THE DATASET.
n1=10; %the number of bits per sample
L=2^n1; %according to pulse code modulation; exponential relationship
xmax=488; %providing max value for input signal
xmin=-488;%providing min value for input signal
del=(xmax-xmin)/L; % the levels between xmin and xmax
partition=xmin:del:xmax;% definition of decision lines
% partition gives definition of decision lines with an increment of del in levels between max and min.
codebook=xmin-(del/2):del:xmax+(del/2);    % definition of representation levels
% codebook gives the definition of representation levels and contains the quantized values.
%index-to which the decimal number is assigned-index numbers
%quants-the actual quantized values
[index,quants]=quantiz(signal_1,partition,codebook); 
%the quantization process, gives the rounded off value of the samples	
figure(3); %third plot page
hold on; %holding on the figure
stem(quants,'linewidth',2); %plotting of the quantized signal with a line thickness of 2
set(gca,'fontsize',13,'fontweight','bold');  %to enhance figure boldness
axis([0 50 -1.5 2])  %specifying axis of the dataset as the dataset is a real world information
% the size of the dataset is huge, hence plotting a portion
% of the dataset
title('Quantized data plot','fontsize',15,'fontweight','bold');
xlabel('Time','fontsize',12,'fontweight','bold'); %plot specifications
ylabel('Magnitude','fontsize',12,'fontweight','bold');
hold off;

% NORMALIZATION
l1=length(index);%length of the index values
% to convert 1 to n as 0 to n-1 indicies
for i=1:l1
    if (index(i)~=0) %To make index as binary decimal so started from 0 to n
        index(i)=index(i)-1; %iteration till it achieves the max value
    end %end of if loop
end %end of for loop
l2=length(quants); %to convert the end representation levels in between the range
for i=1:l2 % To make quantize value in between the levels.		 
    if(quants(i)==xmin-(del/2))
        quants(i)=xmin+(del/2); % to convert the end representation levels within the range
    end
    if(quants(i)==xmax+(del/2))
        quants(i)=xmax-(del/2);
    end
end

%  ENCODING THE SIGNAL DATA
code=de2bi(index,'left-msb'); 	% DECIMAL TO BINANRY CONV OF INDICIES
k=1;
for i=1:l1 % running loops through all elements in the matrix                  
    for j=1:n1
        coded(k)=code(i,j);% to convert column vector to row vector
        j=j+1;
        k=k+1; %continue iteration till it reaches the max value
    end
    i=i+1;
end
figure(4);%fourth plot page
hold on; %holding on to plot the waveform
stairs(coded,'linewidth',2); %plotting the encoded signal
set(gca,'fontsize',13,'fontweight','bold');  %to enhance the figure boldness
axis([0 200 -2 2]) %specifying axis of the dataset as the dataset is a real world information
% the size of the dataset is huge, hence plotting a portion
% of the dataset

%plot of digital signal
title('Encoded signal','fontsize',15,'fontweight','bold'); %plotting the encoded signal
xlabel('Time','fontsize',12,'fontweight','bold'); %plot specifications
ylabel('Magnitude','fontsize',12,'fontweight','bold');
hold off;

%  PROCESS OF DEMODULATION
code1=reshape(coded,n1,(length(coded)/n1)); 
% Reshape function changes the size and shape of the array
index1=bi2de(code1,'left-msb'); %converting binary vectors to decimal.
resignal=del*index+xmin+(del/2);
figure(5); %fifth plot page.
hold on;  %holding on to plot the waveform
plot(resignal,'linewidth',2); %to plot the demod signal.
set(gca,'fontsize',13,'fontweight','bold'); 
axis([0 50 -1.5 2]) %specifying axis of the dataset as the dataset is a real world information
% the size of the dataset is huge, hence plotting a portion
% of the dataset
title('Reconstructed signal','fontsize',15,'fontweight','bold'); 
%to get back the original information on the input signal
xlabel('Time','fontsize',12,'fontweight','bold'); %plot specifications.
ylabel('Magnitude','fontsize',12,'fontweight','bold');
hold off; %figure is plotted. hold off.