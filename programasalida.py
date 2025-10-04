# -*- coding: utf-8 -*-
"""
Created on Wed Oct  1 21:07:46 2025

@author: juanb
"""
import numpy as np
import modulo_calculos as m
import requests
from fastapi import FastAPI
'''
url = "https://rest.isric.org/soilgrids/v2.0/properties/query"
'''

#lon = -5.853268371806371
#lat = 43.35798868518021

#meteorito1 = {'nombre': 'Itokawa', 'diametro': 0.33e3, 'densidad':1.9e3, 'velocidad': 8e3}
#denst = m.densidadsuelo(lat, lon)

    
#print('Itokawa')
#datos = m.meteorito(meteorito1['diametro'], meteorito1['densidad'], meteorito1['velocidad'], denst)

#print(datos)
'''
print('Bennu')
m.meteorito(484.44, 1194,5.3e3,denst)
'''
print('Rame -127')
m.meteoritoprint(872, 3500, 6e3, denst)
'''
print('meteo ruso chikito')
m.meteorito(20,3500,10e3,denst)

print('meteo dinosaurios')
m.meteorito(10e3, 2e3, 20e3, denst)
'''
app = FastAPI()
@app.get("/meteorito")
def meteorito(lat: float, lon: float, diametro: float, densidad:float, velocidad: float, tierra = True):
    dens = m.densidadsuelo(lat, lon)
    dat = m.meteorito(diametro, densidad, velocidad, dens,tierra=tierra)
    return {'radio': dat[0]/2,'terremoto': dat[1], 'onda':dat[2] }

    