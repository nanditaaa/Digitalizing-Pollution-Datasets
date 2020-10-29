clc %for clearing the command window
clear all %for deleting all the variables from the memory
close all %for closing all the plots
Data=csvread('pollutiondata.csv') %reading the csv file
t=Data(:,1); 
%capturing only the 1st column all the rows from the table and storing (years)
x=Data(:,2);
%capturing only the 2nd column all the rows from the table and storing (SO2)
y=Data(:,3);
%capturing only the 3rd column all the rows from the table and storing (NOx)
z=Data(:,4);
%capturing only the 4th column all the rows from the table and storing (VOC)
subplot(3,1,1);
plot(t,x,'linewidth',2); %basic plot of SO2 data over no of years.
set(gca,'fontsize',13,'fontweight','bold');
xlabel("Years",'fontsize',15,'fontweight','bold');
ylabel("Magnitude",'fontsize',12,'fontweight','bold');
title("Emissions of Sulphur Dioxide",'fontsize',15,'fontweight','bold');
subplot(3,1,2);
plot(t,y,'linewidth',2); %basic plot of NOx data over no of years.
set(gca,'fontsize',13,'fontweight','bold');
xlabel("Years",'fontsize',15,'fontweight','bold');
ylabel("Magnitude",'fontsize',12,'fontweight','bold');
title("Emissions of Nitrogen Oxides",'fontsize',15,'fontweight','bold');
subplot(3,1,3);
plot(t,z,'linewidth',2); 
set(gca,'fontsize',13,'fontweight','bold');
xlabel("Years",'fontsize',15,'fontweight','bold');
ylabel("Magnitude",'fontsize',12,'fontweight','bold');
title("Emissions of Methane compounds",'fontsize',15,'fontweight','bold');
table = readtable('pollutiondata.csv','PreserveVariableNames',true); %importing as a table
%When importing spreadsheets containing invalid variable names, Matlab changes them and stores the original column headings 
%in the VariableDescriptions property of the table.
%using stacked plot to use the original variable names on export.
table.Properties.VariableNames = {'Years' 'S02 Gases' 'NOx Gases' 'Methane Gases'} 
%assigning appropriate column names
s=stackedplot(table,{'S02 Gases','NOx Gases','Methane Gases'}) %using stacked plot. 
%stackedplot(tbl) plots the variables of a table or timetable in a stacked plot, up to a maximum of 25 variables. 
%The function plots the variables in separate y-axes, stacked vertically. The variables share a common x-axis.
%The stackedplot function plots all the numeric, logical, categorical, datetime, and duration variables
% and ignores table variables having any other data type.
s.LineProperties(1).PlotType = 'stairs';
s.LineProperties(2).PlotType = 'stairs';
s.LineProperties(3).PlotType = 'stairs';
s.LineWidth = 2;