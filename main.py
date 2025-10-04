# -*- coding: utf-8 -*-
"""
Created on Sat Oct  4 16:39:09 2025

@author: juanb
"""
from fastapi import FastAPI
import modulo_calculos as m

app = FastAPI()
@app.get("/meteorito")
def meteorito(lat: float, lon: float, diametro: float, densidad:float, velocidad: float, tierra = True):
    dens = m.densidadsuelo(lat, lon)
    dat = m.meteorito(diametro, densidad, velocidad, dens,tierra=tierra)
    return {'radio': dat[0]/2,'terremoto': dat[1], 'onda':dat[2] }

