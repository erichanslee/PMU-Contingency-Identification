import os
import urllib2
import time
import glob
from reportlab.lib.pagesizes import letter
from reportlab.lib.units import cm
from reportlab.lib.enums import TA_JUSTIFY
from reportlab.lib.pagesizes import letter
from reportlab.platypus import *
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.units import inch





styles = getSampleStyleSheet()
doc = SimpleDocTemplate("report.pdf", pagesize=letter)
parts = []

## Add header info
filename = 'reportdata.txt'
with open(filename, 'r') as myfile:
    data=myfile.readlines()
parts.append(Paragraph("General Data", styles['Heading1']))
for text in data:
	parts.append(Paragraph(text, styles['Normal']))

## First Part is the Total Scores in Sorted Order
filename = 'finalscores.jpeg'
parts.append(Paragraph("Contingency Scores in Sorted Order", styles['Heading1']))
parts.append(Image(filename, width=8.75*cm, height=6.56*cm))

## Add all images of fittings 
jpegCounter = len(glob.glob1(os.getcwd() ,"*.jpeg")) - 3
parts.append(Paragraph("Damped Exponential Fitting Plots", styles['Heading1']))
for i in range(1, jpegCounter):
	filename = 'fittingerror%d.jpeg' % i 
	parts.append(Image(filename, width=8.75*cm, height=6.56*cm))	

## Add Histograms
parts.append(Paragraph("Bar Plot of score distributions", styles['Heading1']))
parts.append(Paragraph("Unweighted", styles['Normal']))
filename = 'histUnweighted.jpeg'
parts.append(Image(filename, width=8.75*cm, height=6.56*cm))	
parts.append(Paragraph("Weighted", styles['Normal']))
filename = 'histWeighted.jpeg'
parts.append(Image(filename, width=8.75*cm, height=6.56*cm))	


doc.build(parts)