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

import numpy as np
import numpy, scipy.stats
from gnuradio import gr
from scipy.stats import chisquare

class ChiSquare(gr.sync_block):
    """
    docstring for block ChiSquare
    """
    def __init__(self, limiar):
        gr.sync_block.__init__(self,
            name="ChiSquare",
            in_sig=[numpy.float32],
            out_sig=[numpy.float32])
        self.limiarT=limiar

    def work(self, input_items, output_items):
		
		arquivo_detec=open('/home/joab/Projeto Sense/detec.txt','a')
		arquivo_sense=open('/home/joab/Projeto Sense/sense.txt','a')
		arquivo_teste=open('/home/joab/Projeto Sense/teste.txt','a')
		
		x = np.random.rayleigh(0.1,len(input_items[0]))
		chi = chisquare(input_items[0], x)
		p = chi[1]
		for i in range(len(input_items[0])):
			a=p * input_items[0][i]
			
			if chi[0] > a:
				
				vetor_dados_sense = [input_items[0][i], a, chi, i]
				vetor_dados_detec = [i, input_items[0][i], a, chi]
				arquivo_sense.write('%s' %vetor_dados_sense)
				arquivo_detec.write('%s' %vetor_dados_detec)
				arquivo_sense.write('\n')
				arquivo_detec.write('\n')
				
		arquivo_sense.close()
		arquivo_detec.close()
		arquivo_teste.close()
		
		return len(output_items[0])

