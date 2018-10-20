getchipertext=function(plaintext,key){
	intToUtf8((utf8ToInt(plaintext)+utf8ToInt(key))-65)
}

getplaintext=function(ciphertext,key){
	intToUtf8((utf8ToInt(ciphertext)-utf8ToInt(key)+65))
}
plaintext = "VWXYZ"
key	="ABCDE"

ciphertext = getchipertext(plaintext,key)
print(ciphertext)

plaintext = getplaintext(ciphertext,key)
print(plaintext)