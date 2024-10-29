from eudplib import *
import math

#Laptop : 'C:\\Users\\whatd\\Desktop\\Stormcoast Fortress\\ScmDraft 2\\MapSource\\MEME_EUD_Project\\'
#Desktop : 'C:\\Users\\USER\\Documents\\MapSource\\MEME_EUD_Project'

def Exec_OggFile():
	#BGM
	BGMArr = ["yodelsong.ogg","happy.ogg","_Hong.ogg","Lethal_Icecream.ogg","Bombyanggang.ogg","fakeqt.ogg","MaraTangFuru.ogg","UnwelcomeSchool.ogg","__CIPI1.ogg","Damedane.ogg","00.ogg","_DDING1.ogg","lolikami_cut.ogg","Toka.ogg","Nyancat.ogg","nodap.ogg","bling.ogg"]
	for i in BGMArr:
		MPQAddFile('staredit\\wav\\'+i, open('C:/euddraft0.9.2.0/MEME_EUD_BGM/'+i, 'rb').read())
	#SE
	SEArr = ["why.ogg","cut.ogg","_999.ogg","_9992.ogg","warn.wav","CanOver.ogg","Jester.ogg"]
	for i in SEArr:
		MPQAddFile('staredit\\wav\\'+i, open('C:/euddraft0.9.2.0/MEME_EUD_BGM/'+i, 'rb').read())