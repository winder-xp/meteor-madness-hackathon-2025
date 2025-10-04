# -*- coding: utf-8 -*-
"""
Created on Wed Oct  1 21:07:46 2025

@author: juanb
"""
import numpy as np
import modulo_calculos as m



meteorito1 = {'nombre': 'Itokawa', 'diametro': 0.33e3, 'densidad':1.9e3, 'velocidad': 8e3}

'''
hestallido = m.alturaestallido(meteorito1['densidad'],meteorito1['diametro'],meteorito1['velocidad'])
print('El meteorito se rompe en cachos a ', hestallido, 'm')

factordispersion = m.factordedispersion(meteorito1['densidad'],meteorito1['diametro'],meteorito1['velocidad'])
desintegracion = m.alturadesintegracion(hestallido, factordispersion)

print('Se desintegra del todo a ', desintegracion, '(False es que choca)')

vimpacto = m.vsuelonodesi(meteorito1['densidad'],meteorito1['diametro'],meteorito1['velocidad'], zest = hestallido)

print('Choca a (m/s)', vimpacto)

diametrorestos = m.diametrometeo(meteorito1['densidad'],meteorito1['diametro'],meteorito1['velocidad'], zest = hestallido)

print(diametrorestos)

diametrotrans = m.diametrocratertrans(meteorito1['densidad'], 1825, diametrorestos, vimpacto)

print(diametrotrans)

diametrofin = m.diametrofinalcrater(diametrotrans)
print(diametrofin)
'''
print('Itokawa')
m.meteorito(meteorito1['diametro'], meteorito1['densidad'], meteorito1['velocidad'], 1825)

print('Bennu')
m.meteorito(484.44, 1194,5.3e3,1825)

print('Rame -127')
m.meteorito(872, 3500, 6e3, 1825)

print('meteo ruso chikito')
m.meteorito(20,3500,10e3,1825)

print('meteo dinosaurios')
m.meteorito(10e3, 2e3, 20e3, 1825)