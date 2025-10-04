# -*- coding: utf-8 -*-
"""
Este es el módulo con todos los cálculos importantes necesarios para el 
problema de la colisión del meteorito.
"""
###
#Imports
###
import numpy as np
import requests
import math
#import matplotlib.pyplot as plt


###
#Conversiones importantes
###

MT = 4.18e15    #Equivalencia MT de TNT a J
kT = 4.184e12   #1KT = J

###
#Datos
###

H = 8000    #Altura de referencia en metros para la densidad del aire
rho0 = 1    #Densidad del aire en la superficie de la tierra en kg/m^3
g = 9.81    #Aceleración de la gravedad en m/s^2


###
#Funciones
###

def einicial(densidad, diametro, velocidad):
    '''
    Esta función calcula la energía cinética inicial del meteorito en Julios,
    en base a su densidad, su diámetro y su velocidad. Se asume la forma del
    meteorito como una esfera homogenea.
    
    Retorna el valor de la energía en Julios

    Parameters
    ----------
    densidad : float
        Densidad del meteorito en kg/m^3.
    diametro : float
        Diámetro del meteorito en metros.
    velocidad : float
        velocidad del meteorito en m/s.

    Returns
    -------
    energia : float.
        Valor de la energía del meteorito en J

    '''
    assert densidad>0, 'La densidad debe ser positiva'
    assert diametro>0, 'El diámetro debe ser positivo'
    assert velocidad>0 and velocidad<3e8, 'La velocidad debe ser positiva y menor a la velocidad de la luz'
    
    energia = np.pi/12*densidad*(diametro**3)*velocidad**2
    
    return energia

#print(einicial(1,0,1))

def densidaddelaire(altura):
    '''
    Esta función calcula la densidad del aire a una altura dada en kg/m^3 

    Parameters
    ----------
    altura : float
        Altura en metros a la que se quiere calcular la densidad.

    Returns
    -------
    densidad : float.
        Densidad del aire a esa altura en kg/m^3

    '''
    assert altura>=0, 'La altura debe estar dentro de la atmósfera'
    densidad = rho0* np.exp(-(altura/H))
    return densidad

#print(densidaddelaire(0))
#print(densidaddelaire(100))

def velocidadmeteoini(z, diam, dens, v0,theta=np.pi/2, CD=2):
    '''
    Esta función calcula la velocidad del meteorito a una determinada altura
    suponiendo que aún no se ha roto en pedazos.

    Parameters
    ----------
    z : float
        Altura a la que se quiere medir la velocidad en m.
    diam : float
        Diámetro del meteorito en m.
    dens : float
        Densidad del meteorito en kg/m^3.
    v0 : float
        Velocidad en la parte superior de la atmosfera en m/s
    theta : float, optional
        Ángulo de incidencia del meteorito en rad. Por default es pi/2 porque
        es el valor más común
    CD : float, optional
        Coeficiente de arrastre del meteorito. Por default es 2.

    Returns
    -------
    velocidad : float.
        Velocidad a la altura pedida en m/s. Es 0 si el asteroide se va a 
        desintegrar fijo en la atmosfera (Esto se hace porque la aproximacion
        es mala para estos valores)
        
    

    '''
    assert z>=0, 'La altura debe estar dentro de la atmósfera'
    assert dens>0, 'La densidad debe ser positiva'
    assert diam>0, 'El diámetro debe ser positivo'
    assert v0>0 and v0<3e8, 'La velocidad debe ser positiva y menor a la velocidad de la luz'
    assert theta>=0 and theta<=np.pi, 'El ángulo de incidencia debe estar entre 0 y pi'
    assert CD>0, 'El coeficiente de arrastre debe ser positivo'
    if diam<10:
        #Cuando un meteorito tiene menos de 10m de diametro se desintegra en 
        #la atmósfera.
        
        return False
    else:
        rho = densidaddelaire(z)
        #print(np.exp(-((3*rho*CD*H)/(4*dens*diam*np.sin(theta)))))
        velocidad = v0* np.exp(-((3*rho*CD*H)/(4*dens*diam*np.sin(theta))))
    
        return velocidad


'''
x = np.linspace(0,500,20000)
print(x)
y = velocidadmeteoini(x,100,100,500)
print(y[0])
plt.plot(x,y)

plt.show()
'''

def resistenciaP(densidad):
    '''
    Esta función calcula la resistencia que tiene el meteorito a la presión
    externa durante la entrada en la atmósfera mediante una relación empírica

    Parameters
    ----------
    densidad : float
        Densidad del satélite en kg/m^3.

    Returns
    -------
    resistencia : float
        Resistencia a la presión externa en la reentrada en Pa.

    '''
    assert densidad>900 and densidad<10000, 'La densidad debe estar en el intervalo (900,10000) kg/m^3 para ser coherentes'
    
    exponente = 2.107 + 0.0624*np.sqrt(densidad)
    #print(exponente)
    resistencia = 10**exponente
    return resistencia


#print(resistenciaP(0.01))

def indicadorprobestallido(densidad, diametro, v0, theta = np.pi/2, CD = 2):
    '''
    Esta función calcula un indicador de donde va a explotar el meteorito, que
    ya va a aportar una información previa que permitirá ahorrar cálculos, y se
    utilizará más adelante para calcular la altura en la que explota el 
    meteorito. 
    
    Si el resultado de este indicador es mayor que 1, el meteorito no explota.
    Si en su defecto es menor que 1, sí explota antes de tocar el suelo

    Parameters
    ----------
    densidad : float
        Densidad del meteorito en kg/m^3.
    diametro : float
        Diámetro del meteorito en m.
    v0 : float
        Velocidad del meteorito en m/s.
    theta : float, optional
        Ángulo de incidencia del meteorito en radianes. The default is np.pi/2.
    CD : float, optional
        Coeficiente de arrastre del meteorito. The default is 2.

    Returns
    -------
    indicador : float
        Indicador de probabilidad de estallido

    '''
    Yi = resistenciaP(densidad)
    
    indicador = 4.07* ((CD*H*Yi)/(densidad*diametro*v0*v0*np.sin(theta)))
    
    return indicador

#print(indicadorprobestallido(4000, 20000, 50))

def alturaestallido(densidad, diametro, v0, theta = np.pi/2, CD = 2):
    '''
    Esta función calcula la altura a la que estalla el meteorito si es que 
    estalla, en caso contrario devuelve un 0

    Parameters
    ----------
    densidad : float
        Densidad del meteorito en kg/m^3.
    diametro : float
        Diámetro del meteorito en m.
    v0 : float
        Velocidad del meteorito en m/s.
    theta : float, optional
        Ángulo de incidencia del meteorito en radianes. The default is np.pi/2.
    CD : float, optional
        Coeficiente de arrastre del meteorito. The default is 2.

    Returns
    -------
    altura : float
        Altura del estallido en m.

    '''
    If = indicadorprobestallido(densidad, diametro, v0, theta, CD)
    #print(If)
    if If>=1:
        #print('a')
        return 0 
    else:
        Yi = resistenciaP(densidad)
        #print(If)
        altura = -H*(np.log((Yi)/(rho0*v0*v0))+1.308-0.314*If-1.303*np.sqrt(1-If))
        #print(np.log((Yi)/(rho0*v0*v0)))
        #print(altura)
        if altura<=0:
            return 0 
        else:
            return altura
    
#print(alturaestallido(3000, 10, 17000))

def velocidadterminal(densidad, diametro, CD=2, z=0):
    '''
    Esta función calcula la velocidad terminal del meteorito, que será la cota
    inferior de velocidad en el impacto con el suelo
    
    Parameters
    ----------
    densidad : float
        Densidad del meteorito en kg/m^2.
    diametro : float
        Diámetro del meteorito en m.
    CD : foat o int, optional
        Coeficiente de rozamiento. The default is 2.
    z : float, optional
        altura a la que se quiere calcular. The default is 0.

    Returns
    -------
    vterminal : float
        Velocidad terminal del meteorito en m/s.

    '''
    assert z>=0, 'z debe ser positivo'
    assert densidad>0 and diametro>0, 'La densidad y el diámetro deben ser positivas'
    densidadaire = densidaddelaire(z)
    vterminal = np.sqrt((4*diametro*g*densidad)/(3*densidadaire*CD))
    return vterminal

#print(velocidadterminal(1000, 10))

def factordedispersion(densidad, diametro, v0, theta = np.pi/2, CD = 2,zest=-1, z0 = False):
    '''
    Se asume que a esta función solo se le llama si el meteorito estalla.
    
    Esta función calcula el factor de dispersión del meteorito después de 
    estallar, lo cual se usará para calcular el diámetro del cráter.
    
    Devuelve el factor de dispersión, o el factor de dispersión más la 
    altura a la que estalla por si se necesitase

    Parameters
    ----------
    densidad : float
        Densidad del meteorito en kg/m^3.
    diametro : float
        Diámetro del meteorito en m.
    v0 : float
        Velocidad inicial del meteorito en m/s.
    theta : float, optional
        Ángulo de entrada del meteorito en rad. The default is np.pi/2.
    CD : float o int, optional
        Coeficiente de arrastre. The default is 2.
    zest : float, optional
        Altura de estallido en m, el -1 representa que no se sabe.
        The default is -1.
    z0 : Bool, optional
        Si se quiere en el retorno la altura de estallido. The default is False.

    Returns
    -------
    
        factor : float.
            Factor de disperisión del meteorito.
        zest : float
            Altura de estallido del meteorito en m.

    '''
    if zest==-1:
        zest = alturaestallido(densidad, diametro, v0, theta, CD)
    
    assert zest>0, 'Si no estalla no tiene sentido este valor'
        
    densidadaire = densidaddelaire(zest)
    
    factor = diametro * np.sin(theta) * np.sqrt((densidad)/(CD*densidadaire))
    
    if z0 == True:
        return [factor, zest]
    else:
        return factor
    
#print(factordedispersion(1500, 1000, 10000,z0=True))


def diametrometeo(densidad, diametro0, v0, z=0, theta = np.pi/2, CD = 2,zest=-1,
                  z0 = False, factor = -1):
    '''
    Esta función calcula el diametro del meteorito después de que estalle a 
    una altura z se entiende que posterior al estallido.

    Parameters
    ----------
    densidad : float
        Densidad del meteorito en kg/m^3.
    diametro : float
        Diámetro del meteorito en m.
    v0 : float
        Velocidad inicial del meteorito en m/s.
    z : float, optional
        Altura a la que se evalua la dispersión. The default is 0.
    theta : float, optional
        Ángulo de entrada del meteorito en rad. The default is np.pi/2.
    CD : float o int, optional
        Coeficiente de arrastre. The default is 2.
    zest : float, optional
        Altura de estallido en m, el -1 representa que no se sabe.
        The default is -1.
    z0 : Bool, optional
        Si se quiere en el retorno la altura de estallido. The default is False.
    factor : float, optional
        Factor de dispersión del meteorito. The default is -1 si no se sabe.

    Returns
    -------
    diametrofin : TYPE
        DESCRIPTION.

    '''
    assert z>=0, 'Hay que evaluar el diámetro a una altura positiva o 0'
    
    if zest==-1:
        zest = alturaestallido(densidad, diametro0, v0, theta, CD)
    
    assert zest>0, 'Si no estalla no tiene sentido este valor'
    
    if factor==-1:
        factor = factordedispersion(densidad, diametro0, v0, theta, CD, zest)
    
    exponencial = np.exp((zest-z)/(2*H))
    
    dentroraiz = 1+ ((((2*H)/factor)**2)*(exponencial-1)**2)
    
    diametrofin = diametro0*np.sqrt(dentroraiz)
    
    if z0 == True:
        return [diametrofin, zest]
    else:
        return diametrofin

#print(diametrometeo(3500,15000,20000))

def alturadesintegracion(zest, factor, factordesintegra = 7):
    '''
    Esta función calcula a la altura a la que se desintegra del todo el meteorito
    si es que se desintegra

    Parameters
    ----------
    zest : float, optional
        Altura de estallido en m.
    factor : float
        Factor de dispersión del meteorito tras romperse.
    factordesintegra : float, optional
        Factor entre L(z) y L0 al que se desintegra el meteorito. The default is 7.

    Returns
    -------
    Altura : float
        Altura a la que se desintegra. Se devuelve False si no se desintegra

    '''
    
    Altura=zest-2*H*np.log(1+((factor)/(2*H))*np.sqrt((factordesintegra**2)-1))
    
    if Altura<0:
        
        return False
    
    return Altura

#print(alturadesintegracion(1000, 10))

def vdesintegrado(densidad, diametro0, v0, theta = np.pi/2, CD = 2,zest=-1,
                  z0 = False, factor = -1, factordesintegra = 7):
    '''
    Esta función calcula la velocidad que tiene los restos de los meteoritos
    en el momento de desintegrarse

    Parameters
    ----------
    densidad : float
        Densidad del meteorito en kg/m^3.
    diametro : float
        Diámetro del meteorito en m.
    v0 : float
        Velocidad inicial del meteorito en m/s.
    theta : float, optional
        Ángulo de entrada del meteorito en rad. The default is np.pi/2.
    CD : float o int, optional
        Coeficiente de arrastre. The default is 2.
    zest : float, optional
        Altura de estallido en m, el -1 representa que no se sabe.
        The default is -1.
    z0 : Bool, optional
        Si se quiere en el retorno la altura de estallido. The default is False.
    factor : float, optional
        Factor de dispersión del meteorito. The default is -1 si no se sabe.
    factordesintegra : float, optional
        Factor entre L(z) y L0 al que se desintegra el meteorito. The default is 7.

    Returns
    -------
    velocidad : float
        Velocidad a la que van los restos cuando estallan.

    '''
    
    
    if zest==-1:
        zest = alturaestallido(densidad, diametro0, v0, theta, CD)
    
    assert zest>0, 'Si no estalla no tiene sentido este valor'
    
    vzest = velocidadmeteoini(zest, diametro0, densidad, v0, theta, CD)
    
    alfa = np.sqrt(factordesintegra**2-1)
    
    l = factordedispersion(densidad, diametro0, v0, theta, CD, zest)
    
    integral = ((l*diametro0**2)/(24))*alfa*(8*(3+alfa**2)+3*alfa*((l)/(H))*(2+alfa**2))
    
    rho = densidaddelaire(zest)
    
    velocidad = vzest*np.exp(-((3*CD*rho)/(4*densidad*diametro0**3*np.sin(theta)))*integral)
    
    #velocidad = max(velocidad, velocidadterminal(densidad, diametro0/2))
    
    
    return velocidad
    
def vsuelonodesi(densidad, diametro0, v0, theta = np.pi/2, CD = 2,zest=-1,
                  z0 = False, factor = -1, factordesintegra = 7):
    '''
    Esta función calcula la velocidad que tiene los restos de los meteoritos
    en el momento de caer al suelo

    Parameters
    ----------
    densidad : float
        Densidad del meteorito en kg/m^3.
    diametro : float
        Diámetro del meteorito en m.
    v0 : float
        Velocidad inicial del meteorito en m/s.
    theta : float, optional
        Ángulo de entrada del meteorito en rad. The default is np.pi/2.
    CD : float o int, optional
        Coeficiente de arrastre. The default is 2.
    zest : float, optional
        Altura de estallido en m, el -1 representa que no se sabe.
        The default is -1.
    z0 : Bool, optional
        Si se quiere en el retorno la altura de estallido. The default is False.
    factor : float, optional
        Factor de dispersión del meteorito. The default is -1 si no se sabe.
    factordesintegra : float, optional
        Factor entre L(z) y L0 al que se desintegra el meteorito. The default is 7.

    Returns
    -------
    velocidad : float
        Velocidad a la que van los restos cuando llegan al suelo.

    '''
    if zest==-1:
        zest = alturaestallido(densidad, diametro0, v0, theta, CD)
    
    assert zest>0, 'Si no estalla no tiene sentido este valor'
    
    #vzest = max(velocidadmeteoini(zest, diametro0, densidad, v0, theta, CD), velocidadterminal(densidad, diametro0/2, CD, zest))
    vzest = velocidadmeteoini(zest, diametro0, densidad, v0, theta, CD)
    #print(velocidadmeteoini(zest, diametro0, densidad, v0, theta, CD), velocidadterminal(densidad, diametro0/2, CD, zest))
    #print(vzest, v0)
    
    rho = densidaddelaire(zest)
    
    l = factordedispersion(densidad, diametro0, v0, theta, CD, zest)
     
    integral = ((H**3*diametro0**2)/(3*l**2))*(34+((l)/(H))**2*np.exp(zest/H)+6*np.exp(2*zest/H)-16*np.exp(3*zest*0.5/H)-3*((l)/(H))**2-2)
    
    velocidad = vzest*np.exp(-((3*CD*rho)/(4*densidad*diametro0**3*np.sin(theta)))*integral)
    #print(np.exp(-((3*CD*rho)/(4*densidad*diametro0**3*np.sin(theta)))*integral))
    #velocidad = max(velocidad, velocidadterminal(densidad, diametro0))
    #print(velocidad, velocidadterminal(densidad, diametro0))
    return velocidad

def diametrocratertrans(densidadmeteo, densidadsuelo, diametrorestos, vimpacto, theta = np.pi/2, g=9.81, agua=False):
    '''
    Esta función calcula el diametro del crater de transición del meteorito

    Parameters
    ----------
    densidadmeteo : float
        Densidad del meteorito en kg/m^3.
    densidadsuelo : float
        Densidad del suelo en kg/m^3.
    diametrorestos : float
        Diametro de los restos que impactan con el suelo en m
    vimpacto : float
        Velocidad de impacto en m/s
    theta : float, optional
        Ángulo de incidencia con la tierra en rad. The default is pi/2.
    g : float, optional
        Gravedad en la Tierra en m/s^2. The default is 9.81.
    agua : Bool, optional
        True si cae en agua, false si cae en tierra. The default is False.

    Returns
    -------
    d : float
        Diametro del crater de transición.

    '''
    valor = ((densidadmeteo)/densidadsuelo)**(1/3)*diametrorestos**0.78*vimpacto**0.44*g**(-0.22)*(np.sin(theta))**(1/3)
    if agua == True:
        d = 1.356*valor
    else:
        d= 1.161*valor
    
    return d

def diametrofinalcrater(diametrotransicion, cratercota = 2.56e3, craterref= 3.2e3):
    '''
    

    Parameters
    ----------
    diametrotransicion : float
        Diametro del crater de transicion en m
    cratercota : float, optional
        Crater cota a partir del cual es complejo el crater. The default is 2.56e3.
    craterref : float, optional
        Crater de referencia en m. The default is 3.2e3.

    Returns
    -------
    Dfin : float
        Diámetro del crater final en m.

    '''
    
    if diametrotransicion<=cratercota:
        Dfin = 1.25*diametrotransicion
    else:
        diametrotransicion/=1e3
        craterref/=1e3
        Dfin = 1.17*((diametrotransicion)**1.13/(craterref)**0.13)*1e3
    
    return Dfin

def seismomagnitud(energia, distancia=0):
    '''
    Esta función calcula la sismicidad de la caida del meteorito en escala
    Mercalli

    Parameters
    ----------
    energia : float
        Energía del meteorito en julios.
    distancia : float, optional
        Distancia a evaluar el terremoto. The default is 0.

    Returns
    -------
    Meff : float
        Valor en la escala Mercalli.

    '''
    
    M = 0.67*np.log10(energia)-5.87
    
    if distancia <= 60e3:
        Meff = M-0.0238*distancia*1e-3 
    elif distancia<700e3 and distancia>60e3:
        Meff = M-0.0048*distancia*1e-3 -1.1644
        
    elif distancia> 700e3:
        Meff = M -1.66*np.log10(np.rad2deg(distancia/6371e3))-6.399
        
    return max(Meff,0)

def escaladoonda(dequiv):
    '''
    Esta función normaliza los datos de la onda expansiva

    Parameters
    ----------
    dequiv : float
        Dinstancia equivalente de la onda expansiva a la onda de un kT TnT
        en m.

    Returns
    -------
    TYPE
    escala : float
        Valor en la escala

    '''
    assert dequiv>=0, 'La distancia equivalente debe ser positiva'
    
    cotas =[126,133,149,155,229,251, 389,411,502,549,1160]
    if dequiv>cotas[-1]:
        return len(cotas)+1
    else:
        for i in range(len(cotas)):
            if dequiv<=cotas[i]:
                return i+1 
                break
            
#print(escaladoonda(1162))
    
def equidistkt(energia, distancia= 0):
    '''
    Calcula la distancia equivalente de la onda expansiva de un KT de TNT

    Parameters
    ----------
    energia : float
        Energía meteorito en J.
    distancia : float, optional
        Distancia en m The default is 0.

    Returns
    -------
    d : float
        Distancia en m

    '''
    
    d = distancia/ (energia/kT)**(1/3)
    
    return d

def meteoritoprint(diametro, densidad,velocidad,densidadsuelo, theta = np.pi/2, tierra= True):
    '''
    Esta función calcula todo lo necesario de los meteoritos

    Parameters
    ----------
    diametro : float
        Diametro del meteorito en m
    densidad : float
        Densidad del meteorito en kg/m^3
    velocidad : float
        Velocidad de entrada m/s.
    densidadsuelo : float
        Densidad del suelo en kg/m^3.
    theta : float, optional
        Ángulo en rad. The default is np.pi/2.
    tierra : bool, optional
        Si cae en agua, este valor es False

    Returns
    -------
    craterf : float
        Diametro del crater final en m.
    terremotos : float
        Magnitud de los terremotos a 0m, 100km, 1000km.
    dists : float
        Distancias equivalentes a una explosion de 1kT TnT para 0m, 100km, 1000km.

    '''
    
    hestallido = alturaestallido(densidad, diametro, velocidad, theta)
    
    if hestallido >0:
        print('El meteorito se parte en cachos a %f m'%(hestallido))
        
        factord = factordedispersion(densidad, diametro, velocidad, theta, zest = hestallido)
        hdesi = alturadesintegracion(hestallido, factord)
        
        if hdesi>0:
            print('El meteorito se desintegra completamente a %f m'%(hdesi))
            craterf = 0 
            rf = hdesi
        else:
            print('El meteorito no se desintegra en la atmosfera')
            vimpact = vsuelonodesi(densidad, diametro, velocidad, theta, zest=hestallido, factor = factord)
            print('El meteorito llega al suelo a una velocidad de %f m/s'%(vimpact))
            diametrorestos = diametrometeo(densidad, diametro, velocidad, zest =hestallido, factor = factord)
            
            cratert = diametrocratertrans(densidad, densidadsuelo, diametrorestos, vimpact, agua = not tierra)
            
            craterf = diametrofinalcrater(cratert)
            print('El diámetro final del crater es de %f m'%(craterf))
            rf = 0
            
    else:
        print('El meteorito cae sin fracturarse')
        vimpact = velocidadmeteoini(0, diametro, densidad, velocidad, theta)
        print('El meteorito llega al suelo a una velocidad de %f m/s'%(vimpact))
        
        cratert = diametrocratertrans(densidad, densidadsuelo, diametro, vimpact, agua = not tierra)
        
        craterf = diametrofinalcrater(cratert)
        
        print('El diámetro final del crater es de %f m'%(craterf))
        rf = 0
    energia = einicial(densidad, diametro, velocidad)
    terremotos = []
    for i in [0,100e3,1000e3]:
        if rf>0:
            break
        terremoto = seismomagnitud(energia, i)
        print('A %i m, el terremoto es de magnitud %f'%(i,terremoto))
        terremotos.append(terremoto)
    
    dists = []
    for i in [diametro,100,500, 1000, 5000, 10000,100000]:
        dist = equidistkt(energia, np.abs(i-rf))
        print('A %i m respecto a la vertical del estallido, es equivalente a estar a %f m de una explosión de 1kT de TNT'%(i,dist))
        
        dists.append(dist)
    print(dists[0])
    return craterf, math.ceil(terremotos[0]), escaladoonda(dists[0])
        
def meteorito(diametro, densidad,velocidad,densidadsuelo, theta = np.pi/2, tierra= True):
    '''
    Esta función calcula todo lo necesario de los meteoritos

    Parameters
    ----------
    diametro : float
        Diametro del meteorito en m
    densidad : float
        Densidad del meteorito en kg/m^3
    velocidad : float
        Velocidad de entrada m/s.
    densidadsuelo : float
        Densidad del suelo en kg/m^3.
    theta : float, optional
        Ángulo en rad. The default is np.pi/2.
    tierra : bool, optional
        Si cae en agua, este valor es False

    Returns
    -------
    craterf : float
        Diametro del crater final en m.
    terremotos : float
        Magnitud de los terremotos a 0m, 100km, 1000km.
    dists : float
        Distancias equivalentes a una explosion de 1kT TnT para 0m, 100km, 1000km.

    '''
    
    hestallido = alturaestallido(densidad, diametro, velocidad, theta)
    
    if hestallido >0:
        #print('El meteorito se parte en cachos a %f m'%(hestallido))
        
        factord = factordedispersion(densidad, diametro, velocidad, theta, zest = hestallido)
        hdesi = alturadesintegracion(hestallido, factord)
        
        if hdesi>0:
            #print('El meteorito se desintegra completamente a %f m'%(hdesi))
            craterf = 0 
            rf = hdesi
        else:
            #print('El meteorito no se desintegra en la atmosfera')
            vimpact = vsuelonodesi(densidad, diametro, velocidad, theta, zest=hestallido, factor = factord)
            #print('El meteorito llega al suelo a una velocidad de %f m/s'%(vimpact))
            diametrorestos = diametrometeo(densidad, diametro, velocidad, zest =hestallido, factor = factord)
            
            cratert = diametrocratertrans(densidad, densidadsuelo, diametrorestos, vimpact, agua = not tierra)
            
            craterf = diametrofinalcrater(cratert)
            #print('El diámetro final del crater es de %f m'%(craterf))
            rf = 0
            
    else:
        #print('El meteorito cae sin fracturarse')
        vimpact = velocidadmeteoini(0, diametro, densidad, velocidad, theta)
        #print('El meteorito llega al suelo a una velocidad de %f m/s'%(vimpact))
        
        cratert = diametrocratertrans(densidad, densidadsuelo, diametro, vimpact, agua = not tierra)
        
        craterf = diametrofinalcrater(cratert)
        
        #print('El diámetro final del crater es de %f m'%(craterf))
        rf = 0
    energia = einicial(densidad, diametro, velocidad)
    terremotos = []
    for i in [0,100e3,1000e3]:
        if rf>0:
            break
        terremoto = seismomagnitud(energia, i)
        #print('A %i m, el terremoto es de magnitud %f'%(i,terremoto))
        terremotos.append(terremoto)
    
    dists = []
    for i in [diametro,100,500, 1000, 5000, 10000,100000]:
        dist = equidistkt(energia, np.abs(i-rf))
        #print('A %i m respecto a la vertical del estallido, es equivalente a estar a %f m de una explosión de 1kT de TNT'%(i,dist))
        
        dists.append(dist)
    #print(dists[0])
    return craterf, math.ceil(terremotos[0]), escaladoonda(dists[0])


def densidadsuelo(lat,lon):
    '''
    Esta función calcula la densidad del suelo dado una latitud y una longitud
    

    Parameters
    ----------
    lat : float
        Latitud.
    lon : float
        Longitud.

    Returns
    -------
    denst : float
        Densidad en kg/m^3.

    '''
    
    url = "https://rest.isric.org/soilgrids/v2.0/properties/query"
    
    params = {
        "lon": lon,      # longitud
        "lat": lat,      # latitud
        "property": "bdod",  # densidad aparente
        "depth": "100-200cm",    # capa de profundidad
    }
    try:
        resp = requests.get(url, params=params).json()

        denst = resp['properties']['layers'][0]['depths'][0]['values']['mean']
    
    except Exception as e:
        denst = None
        print('fallo de API: ', e)
    if denst == None:
        denst = 2400    #Asumimos que es hormigón
    else:
        denst *=10
    
    return denst
    
        
    
    