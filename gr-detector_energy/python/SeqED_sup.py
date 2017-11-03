#!/usr/bin/env python
# -*- coding: utf-8 -*-
# 
# Copyright 2017 <+YOU OR YOUR COMPANY+>.
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

class SeqED_sup(gr.sync_block):
    """
    docstring for block SeqED_sup
    """
    def __init__(self, num_samples, max_sense_slots, limiar_baixo, limiar_alto, estimated_noise_power):
        gr.sync_block.__init__(self,
            name="SeqED_sup",
            in_sig=[numpy.float32],
            out_sig=[numpy.float32])
	self.num_samples = num_samples
	self.max_sense_slots = max_sense_slots
	self.limiar_baixo = limiar_baixo
	self.limiar_alto = limiar_alto
	self.estimated_noise_power = estimated_noise_power


    def work(self, input_items, output_items):
        in0 = input_items[0]
        self.signal = in0 # Vlores de Potencia ficticio
        self.v_decisao = [] # Vetor de decisao - Vetor onde ficam armazenados indices das potencias entre os limiares alto e baixo
        self.quant_v_decisao = 1 # Variavel para controlar a quantidade de entradas no vetor de decisao, para que nao passe de max_sense_slots
	for i in range(self.num_samples):
	    if self.signal[i] <= self.limiar_baixo: # Testa se a potencia em questao eh menor ou igual ao limiar baixo
		print "O canal %d esta desocupado!" %i
		print self.signal[i]
		
	    elif self.signal[i] >= self.limiar_alto: # Testa se a potencia em questao eh maior ou igual ao limiar alto
		print "O canal %d esta ocupado!" %i
		print self.signal[i]
	    else:
		if self.quant_v_decisao <= self.max_sense_slots: # Testa se a quantidade de 
		    self.v_decisao.append(i) # Adiciona a posicao da potencia (no vetor signal), entre os limiares alto e baixo
		    self.quant_v_decisao = self.quant_v_decisao + 1 # Esta variavel eh incrementada, pois, um novo elemento foi adicionado ao vetor v_decisao
		else:
		    #print v_decisao
		    # Esta condicao eh atendida quando um nova entrada para o vetor de decisao eh gerada, mas excede o tamanho max_sense_slots
		    # Se o numero de entradas no v_decisao chegar a max_sense_slots, os elementos de v_decisao serao analisados
		    # De acordo com o limiar de deteccao de energia tradicional, ou seja, um unico valor
		    for n in range(self.max_sense_slots):
			# Testa se a potencia eh menor ou igual ao limiar unico ou maior e igual
			if self.signal[self.v_decisao[n]] <= self.estimated_noise_power: 
			    print self.signal[self.v_decisao[n]]
			    print "O canal %d esta desocupado!" %self.v_decisao[n]
			else: 
			    print self.signal[self.v_decisao[n]]
			    print "O canal %d esta ocupado!" %self.v_decisao[n]
		    self.v_decisao = [] # zera o vetor de decisao para que um novo bloco de sensoriamento seja analizado
		    self.quant_v_decisao = 1 # Esta variehvel eh reinicializada, pois, o vetor v_decisao foi zerado
		    self.v_decisao.append(i) # A potencia que excederia o tamanho do v_decisao eh entao adicionado a este, iniciando um novo bloco de sensoriamento

		# Caso o processamento acima acabe antes que o ultimo bloco de sensoriamento para decisao (v_decisao), seja completo 
		# os canais ficarao sem decisao de ocupacao ou nao, entao, o trecho de codigo abaixo serve para que todos os canais 
		# sejam analizados 

	if self.v_decisao != []: # Testa se ha alguma informacao no vetor de decisao
	    for x in range(len(self.v_decisao)):
		# Testa se a potencia eh menor ou igual ao limiar unico ou maior e igual
		if self.signal[self.v_decisao[x]] <= self.estimated_noise_power:
		    #print "O canal %d esta desocupado!" %v_decisao[x]
		    #print signal[v_decisao[x]]
		    output_items = self.v_decisao[x]
		else:
		    #print "O canal %d esta ocupado!" %v_decisao[x]
		    #print signal[v_decisao[x]]
		    output_items = self.v_decisao[x]

		#print "\n"
		#print len(v_decisao)
		#print v_decisao
		#print quant_v_decisao        
			#out[:] = in0
		
	return len(output_items[0])

