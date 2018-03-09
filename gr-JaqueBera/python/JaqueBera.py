#!/usr/bin/env python
# -*- coding: utf-8 -*-
# 
# Copyright 2018 <+YOU OR YOUR COMPANY+>.
# 
# This is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3, or (at your option)
# any later version.
# 
# This software is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this software; see the file COPYING.  If not, write to
# the Free Software Foundation, Inc., 51 Franklin Street,
# Boston, MA 02110-1301, USA.
# 

from __future__ import division, print_function, absolute_import

import warnings
import math
from collections import namedtuple

import numpy as np
from numpy import array, asarray, ma, zeros

from scipy._lib.six import callable, string_types
from scipy._lib._version import NumpyVersion
import scipy.special as special
import scipy.linalg as linalg
from scipy.stats import distributions
import numpy
from scipy.stats import kurtosis, skew, stats
from gnuradio import gr

class JaqueBera(gr.sync_block):
    """
    docstring for block JaqueBera
    """
    def __init__(self, freq):
        gr.sync_block.__init__(self, name="JaqueBera", in_sig=[numpy.float32], out_sig=[numpy.float32])
        self.freq=freq
			

    def work(self, input_items, output_items):
		arquivo_detec=open('/home/joab/Projeto Sense/detec.txt','a')
		arquivo_sense=open('/home/joab/Projeto Sense/sense.txt','a')
		arquivo_teste=open('/home/joab/Projeto Sense/teste.txt','a')
		
		
		n = float(input_items[0].size)
		mu = input_items[0].mean()
		diffx = input_items[0] - mu
		skewness = (1 / n * np.sum(diffx**3)) / (1 / n * np.sum(diffx**2))**(3 / 2.)
		kurtosis = (1 / n * np.sum(diffx**4)) / (1 / n * np.sum(diffx**2))**2
		JB = n / 6 * (skewness**2 + (kurtosis - 3)**2 / 4)
		p = 1 - distributions.chi2.cdf(JB, 2)
		for i in range(len(input_items[0])):
			a=p * input_items[0][i]
			
			if JB > a:
				
				#vetor_dados_sense = [input_items[0][i], a, JB, i, freq]
				vetor_dados_detec = [p, input_items[0][i], a, JB, self.freq]
				#arquivo_sense.write('%s' %vetor_dados_sense)
				arquivo_detec.write('%s' %vetor_dados_detec)
				#arquivo_sense.write('\n')
				arquivo_detec.write('\n')
				
		arquivo_sense.close()
		arquivo_detec.close()
		arquivo_teste.close()
		return len(output_items[0])

