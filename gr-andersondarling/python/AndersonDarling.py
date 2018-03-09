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

import numpy
from gnuradio import gr
from scipy.stats import anderson

class AndersonDarling(gr.sync_block):
    """
    docstring for block AndersonDarling
    """
    def __init__(self, freq):
        gr.sync_block.__init__(self,
            name="AndersonDarling",
            in_sig=[numpy.float32],
            out_sig=[numpy.float32])
        self.freq=freq


    def work(self, input_items, output_items):
		
		arquivo_detec=open('/home/joab/Projeto Sense/detec.txt','a')
		arquivo_sense=open('/home/joab/Projeto Sense/sense.txt','a')
		arquivo_teste=open('/home/joab/Projeto Sense/teste.txt','a')
		
		AD = anderson(input_items[0], dist='norm')
		
		for i in range(len(input_items[0])):
			#a=p * input_items[0][i]
			
			if AD[0] > input_items[0][i]:
				
				#vetor_dados_sense = [input_items[0][i], a, JB, i, freq]
				vetor_dados_detec = [i, input_items[0][i], AD[0], self.freq]
				#arquivo_sense.write('%s' %vetor_dados_sense)
				arquivo_detec.write('%s' %vetor_dados_detec)
				#arquivo_sense.write('\n')
				arquivo_detec.write('\n')
				
		arquivo_sense.close()
		arquivo_detec.close()
		arquivo_teste.close()
		
		return len(output_items[0])

