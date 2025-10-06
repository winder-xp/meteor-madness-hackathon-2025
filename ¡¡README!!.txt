#WARNING! THESE COMMANDS ARE NECESSARY IN ORDER TO RUN THE EXECUTABLE API SCRIPT VIDEOGAME.

#THESE COMMANDS HAVE TO BE RUN ON POWERSHELL TERMINAL (BASH IN CASE OF LINUX/UBUNTU).

#IN ADDITION, PYTHON3 HAS TO BE INSTALLED

##################################################################################################################

cd C:\Users\<your-username>\<path-where-'meteor-madness-hackathon-2025'-is-located>\meteor-madness-hackathon-2025\ 

.\mi_entorno\Scripts\actívate

py -m pip install fastapi uvicorn   

pip install requests 

pip install numpy


##################################################################################################################

#THIS COMMAND HAS TO BE RUN EVERY TIME YOU FANCY PLAYING VIDEOGAME

python -m uvicorn main:app --reload

#KEEP THE TERMINAL OPEN

#WHEN YOU FINISH YOUR GAME, DESACTIVATE WITH ' CTRL ' + ' Z '

###################################################################################################################


#ENJOY :)
