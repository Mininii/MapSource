from eudplib import *
import math
def onPluginStart():
	#BGM
	BGMArr = ["yodelsong.ogg","happy.ogg","_Hong.ogg","Lethal_Icecream.ogg","Bombyanggang.ogg"]
	for i in BGMArr:

		MPQAddFile('staredit\\wav\\'+i, open('C:/euddraft0.9.2.0/MEME_EUD_BGM/'+i, 'rb').read())

	#SE
	SEArr = ["why.ogg","cut.ogg","_999.ogg","_9992.ogg","warn.wav","CanOver.ogg"]
	for i in SEArr:
		MPQAddFile('staredit\\wav\\'+i, open('C:/euddraft0.9.2.0/MEME_EUD_BGM/'+i, 'rb').read())
